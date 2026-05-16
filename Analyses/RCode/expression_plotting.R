rm(list=ls())

library(ggplot2)
library(dplyr)
library(purrr)

setwd("C:/_Bioinformatics/GenomeAnalysis/Project/05_Expression/PacBio_prokka/csv/")

# Load all three datasets
rna_res      <- read.csv("RNA_DESeq2_results.csv")
tn_Serum     <- read.csv("TN_BH_S_DESeq2_results.csv")
tn_HSerum    <- read.csv("TN_BH_HS_DESeq2_results.csv")

# Put them in a named list
datasets <- list(
  RNA       = rna_res,
  TN_Serum  = tn_Serum,
  TN_HSerum = tn_HSerum
)

# Volcano plot function
make_volcano <- function(df, title_name) {
  
  df <- df %>%
    filter(!is.na(log2FoldChange), !is.na(padj)) %>%
    mutate(Significance = case_when(
      padj < 0.05 & log2FoldChange > 0 ~ "Upregulated",
      padj < 0.05 & log2FoldChange < 0 ~ "Downregulated",
      TRUE ~ "Not significant"
    ))
  
  ggplot(df, aes(x = log2FoldChange, y = -log10(padj), color = Significance)) +
    geom_point(alpha = 0.8, size = 2) +
    scale_color_manual(values = c(
      "Upregulated" = "red",
      "Downregulated" = "blue",
      "Not significant" = "grey70"
    )) +
    geom_vline(xintercept = c(-1, 1), linetype = "dashed") +
    geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
    theme_minimal(base_size = 14) +
    labs(
      title = paste("Volcano Plot:", title_name),
      x = "Log2 Fold Change",
      y = "-Log10 Adjusted p-value"
    )
}

# Generate and print all plots
plots <- imap(datasets, make_volcano)

# Print them one after another
for (p in plots) print(p)
