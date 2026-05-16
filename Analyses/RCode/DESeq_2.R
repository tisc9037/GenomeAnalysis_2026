rm(list=ls())

setwd("C:/_Bioinformatics/GenomeAnalysis/Project/05_Expression/PacBio_Prokka/") 

library(DESeq2)
library(stringr)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(apeglm)


# 1. Set directory with counts
count_dir <- getwd()
files <- list.files(count_dir, pattern="*.counts", full.names=FALSE)

# Create output directory if missing
if(!dir.exists("csv")){
  dir.create("csv")
}

# 2. Separate RNA and TN files
rna_files <- files[grepl("^RNA", files)]
tn_files  <- files[grepl("^TN",  files)]

# 3. Helper function to build sample table
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
    
    replicate = str_extract(file_list, "_[0-9]+") |> 
      str_remove("_")
  )
}

# 4. Build sample tables
rna_table <- build_sample_table(rna_files)

tn_table_BH_S <- subset(
  build_sample_table(tn_files),
  condition %in% c("BH","Serum")
)

tn_table_BH_HS <- subset(
  build_sample_table(tn_files),
  condition %in% c("BH","HSerum")
)

# 5. Build DESeq2 datasets
dds_rna <- DESeqDataSetFromHTSeqCount(
  rna_table,
  count_dir,
  design = ~ condition
)

dds_tn_BH_S <- DESeqDataSetFromHTSeqCount(
  tn_table_BH_S,
  count_dir,
  design = ~ condition
)

dds_tn_BH_HS <- DESeqDataSetFromHTSeqCount(
  tn_table_BH_HS,
  count_dir,
  design = ~ condition
)

# Optional: remove very low count genes
dds_rna <- dds_rna[rowSums(counts(dds_rna)) > 10, ]

# 6. Run DESeq2
dds_rna      <- DESeq(dds_rna)
dds_tn_BH_S  <- DESeq(dds_tn_BH_S)
dds_tn_BH_HS <- DESeq(dds_tn_BH_HS)


# 7. Extract normalized counts
# DESeq2 size-factor normalization
norm_counts_rna <- counts(
  dds_rna,
  normalized = TRUE
)

# Save normalized counts
write.csv(
  as.data.frame(norm_counts_rna),
  "csv/RNA_normalized_counts.csv"
)

# 8. Save size factors
rna_sizeFactors <- data.frame(
  sample = colnames(dds_rna),
  sizeFactor = sizeFactors(dds_rna)
)

write.csv(
  rna_sizeFactors,
  "csv/RNA_sizeFactors.csv",
  row.names = FALSE
)

# 9. Variance stabilizing transformation
# Recommended for PCA / heatmaps / clustering
vsd_rna <- vst(
  dds_rna,
  blind = FALSE
)

# Extract transformed matrix
vsd_matrix <- assay(vsd_rna)

# Save transformed counts
write.csv(
  as.data.frame(vsd_matrix),
  "csv/RNA_VST_counts.csv"
)


# 10. RNA-seq differential expression
# Shrink log2 fold changes
res_rna <- lfcShrink(
  dds_rna,
  coef = "condition_Serum_vs_BH",
  type = "apeglm"
)

# 11. TN-seq differential expression
res_tn_BH_S <- lfcShrink(
  dds_tn_BH_S,
  coef = "condition_Serum_vs_BH",
  type = "apeglm"
)

res_tn_BH_HS <- lfcShrink(
  dds_tn_BH_HS,
  coef = "condition_HSerum_vs_BH",
  type = "apeglm"
)


# 12. Save DESeq2 results
write.csv(
  as.data.frame(res_rna),
  "csv/RNA_DESeq2_results.csv"
)

write.csv(
  as.data.frame(res_tn_BH_S),
  "csv/TN_BH_S_DESeq2_results.csv"
)

write.csv(
  as.data.frame(res_tn_BH_HS),
  "csv/TN_BH_HS_DESeq2_results.csv"
)

