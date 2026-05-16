rm(list=ls())

setwd("C:/_Bioinformatics/GenomeAnalysis/Project/Counts") 

library(DESeq2)
library(stringr)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(apeglm)
library(tibble)

# -----------------------------
# 1. Set directory with counts
count_dir <- getwd()
files <- list.files(count_dir, pattern="*.counts", full.names=FALSE)
rna_files <- files[grepl("^RNA", files)]

# -----------------------------
# 2. Build sample table
build_sample_table <- function(file_list) {
  tibble(
    fileName   = file_list,
    sampleName = file_list,
    condition  = case_when(
      str_detect(file_list, "BH")     ~ "BH",
      str_detect(file_list, "HSerum") ~ "HSerum",
      str_detect(file_list, "Serum")  ~ "Serum",
      TRUE ~ "Unknown"
    ),
    replicate = str_extract(file_list, "_[0-9]+") |> str_remove("_")
  )
}

rna_table <- build_sample_table(rna_files)

# -----------------------------
# 3. Calculate % mapped reads for each .counts file
mapping_stats <- lapply(rna_files, function(f) {
  
  df <- read.table(file.path(count_dir, f), 
                   header = FALSE, stringsAsFactors = FALSE)
  colnames(df) <- c("feature", "count")
  
  # HTSeq special categories start with "__"
  special <- df[grepl("^__", df$feature), ]
  genes   <- df[!grepl("^__", df$feature), ]
  
  mapped_reads  <- sum(genes$count)
  special_reads <- sum(special$count)
  total_reads   <- mapped_reads + special_reads
  
  tibble(
    fileName = f,
    mapped_reads = mapped_reads,
    special_reads = special_reads,
    total_reads = total_reads,
    percent_mapped = mapped_reads / total_reads * 100
  )
}) |> bind_rows()

# Print mapping summary
print(mapping_stats)

write.table(mapping_stats,file='mapping.txt')
# -----------------------------
# 4. Build DESeq2 object
dds_rna <- DESeqDataSetFromHTSeqCount(
  sampleTable = rna_table,
  directory   = count_dir,
  design      = ~ condition
)



# -----------------------------
# 5. Build long table of gene counts per sample

all_counts <- lapply(rna_files, function(f) {
  df <- read.table(file.path(count_dir, f), header = FALSE, stringsAsFactors = FALSE)
  colnames(df) <- c("feature", "count")
  
  # Remove HTSeq special rows
  df <- df[!grepl("^__", df$feature), ]
  
  tibble(
    fileName = f,
    gene = df$feature,
    count = df$count
  )
}) |> bind_rows()

# Add condition (BH / Serum / HSerum)
all_counts <- all_counts %>%
  mutate(condition = case_when(
    str_detect(fileName, "BH") ~ "BH",
    str_detect(fileName, "Serum") ~ "Serum",
    TRUE ~ "Other"
  ))

# -----------------------------
# 6. Filter out non-expressed genes (count = 0)
expressed_counts <- all_counts %>% 
  filter(count > 0) %>%
  mutate(log_count = log10(count + 1))

# -----------------------------
# 7. Split into BH and Serum
bh_counts <- expressed_counts %>% filter(condition == "BH")
serum_counts <- expressed_counts %>% filter(condition == "Serum")

# -----------------------------
# 8. Plot BH histogram
ggplot(bh_counts, aes(x = log_count)) +
  geom_histogram(bins = 100, fill = "steelblue", color = "black") +
  labs(
    title = "Gene Expression Distribution (BH samples)",
    x = "log10(count + 1)",
    y = "Number of genes"
  ) +
  theme_minimal()

# -----------------------------
# 9. Plot Serum histogram
ggplot(serum_counts, aes(x = log_count)) +
  geom_histogram(bins = 100, fill = "darkorange", color = "black") +
  labs(
    title = "Gene Expression Distribution (Serum samples)",
    x = "log10(count + 1)",
    y = "Number of genes"
  ) +
  theme_minimal()

