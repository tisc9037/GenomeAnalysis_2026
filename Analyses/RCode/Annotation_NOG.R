rm(list=ls())

library(tidyverse)

### 1. Load RNA-seq DESeq2 results
rna <- read.csv("RNA_DESeq2_results.csv") %>%
  rename(gene = X) %>% 
  mutate(
    padj = as.numeric(padj),
    log2FoldChange = as.numeric(log2FoldChange)
  )

### 2. Load TN-seq RPKM long-format table
tn <- read.csv("TNseq_RPKM_long_format.csv")

### 3. Summarize TN-seq importance per gene
tn_summary <- tn %>%
  group_by(gene) %>%
  summarise(
    mean_RPKM = mean(RPKM, na.rm = TRUE),
    median_RPKM = median(RPKM, na.rm = TRUE),
    n_samples = n()
  )

### 4. Select important RNA-seq genes
rna_sig <- rna %>%
  filter(padj < 0.05 & abs(log2FoldChange) > 1)

### 5. Load annotation file (eggNOG)
annot <- read.delim("Efaecium_eggnog.emapper.annotations", sep = "\t", header = TRUE) %>%
  rename(gene = X.query)

### 6. Merge RNA-seq significant genes with annotation
rna_annotated <- rna_sig %>%
  left_join(annot, by = "gene") %>%
  arrange(padj, desc(abs(log2FoldChange)))

### 7. Merge TN-seq summary with annotation
tn_annotated <- tn_summary %>%
  left_join(annot, by = "gene") %>%
  arrange(desc(mean_RPKM))

### 8. Save separate output files
write.csv(rna_annotated, "RNA_important_genes_annotated.csv", row.names = FALSE)
write.csv(tn_annotated, "TN_genes_annotated.csv", row.names = FALSE)
