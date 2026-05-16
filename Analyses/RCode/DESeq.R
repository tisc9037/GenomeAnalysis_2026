rm(list=ls())

setwd("C:/_Bioinformatics/GenomeAnalysis/Project/05_Expression/PacBio_Prokka/") 

library(DESeq2)
library(stringr)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(apeglm)

# -----------------------------
# 1. Set directory with counts
count_dir <- getwd()
files <- list.files(count_dir, pattern="*.counts", full.names=FALSE)

# -----------------------------
# 2. Separate RNA and TN files
rna_files <- files[grepl("^RNA", files)]
tn_files  <- files[grepl("^TN",  files)]

# -----------------------------
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
    replicate = str_extract(file_list, "_[0-9]+") |> str_remove("_")
  )
}

# -----------------------------
# 4. Build sample tables
rna_table <- build_sample_table(rna_files)
tn_table_BH_S  <- subset(build_sample_table(tn_files), condition %in% c("BH","Serum"))
tn_table_BH_HS <- subset(build_sample_table(tn_files), condition %in% c("BH","HSerum"))

# -----------------------------
# 5. Build DESeq2 datasets
dds_rna <- DESeqDataSetFromHTSeqCount(rna_table, count_dir, design = ~ condition)
dds_tn_BH_S  <- DESeqDataSetFromHTSeqCount(tn_table_BH_S, count_dir, design = ~ condition)
dds_tn_BH_HS <- DESeqDataSetFromHTSeqCount(tn_table_BH_HS, count_dir, design = ~ condition)

# -----------------------------
# 6. Run DESeq2
dds_rna      <- DESeq(dds_rna)
dds_tn_BH_S  <- DESeq(dds_tn_BH_S)
dds_tn_BH_HS <- DESeq(dds_tn_BH_HS)

# -----------------------------
# 7. Shrink log2 fold changes (recommended!)
res_rna <- results(
  dds_rna,
  contrast = c("condition", "Serum", "BH"),
  lfcThreshold = 1,
  altHypothesis = "greaterAbs"
  )
res_tn_BH_S  <- lfcShrink(dds_tn_BH_S, coef="condition_Serum_vs_BH", type="apeglm")
res_tn_BH_HS <- lfcShrink(dds_tn_BH_HS, coef="condition_HSerum_vs_BH", type="apeglm")

# -----------------------------
# 8. Save results
write.csv(as.data.frame(res_rna),      "csv/RNA_DESeq2_results_shrunk.csv")
write.csv(as.data.frame(res_tn_BH_S),  "csv/TN_BH_S_DESeq2_results_shrunk.csv")
write.csv(as.data.frame(res_tn_BH_HS), "csv/TN_BH_HS_DESeq2_results_shrunk.csv")
