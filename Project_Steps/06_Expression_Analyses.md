# Expression Analyses
## Goal
The aim of the expression analysis is to identify genes that are differentially expressed between conditions, evaluate how samples cluster, and compare the resulting transcriptional patterns with those reported in Zhang et al., 2017. A secondary goal is to relate RNA‑seq expression changes to Tn‑seq fitness determinants to identify genes that are likely important for E. faecium growth in human serum.

## Results
### RNA‑seq summary
The RNA‑seq data show only modest transcriptional changes between conditions. Several practical issues reduce sensitivity compared with the published work: many genes have very low or zero counts in the DESeq2 tables, which prevents stable dispersion and fold‑change estimates; sequencing depth and replicate numbers are lower here than in the publication; and preprocessing choices (trimming, mapping, counting, filtering) differ. Taken together, these factors explain why relatively few genes survive multiple‑testing correction.

Replicates tend to cluster by condition, which indicates a real biological signal, but separation is not strong. Log2 fold‑changes are generally small and most genes lie near zero, so although replicates are similar to one another, overall variance and low counts limit the ability to call many robust DE genes. A PCA would probably show a modest BH versus serum separation, with serum and heat‑inactivated serum closer together.

Differential expression lists were ranked by adjusted p‑value first and then by absolute log2 fold change. Prioritizing adjusted p‑value controls the false discovery rate; using |log2FC| next highlights genes with larger, biologically meaningful changes. For the sparse Tn‑seq data, many padj values are NA, so ranking relied on p‑value and negative log2 fold change (depletion in serum) to flag candidate essential genes.

Normalization is required for RNA‑seq; DESeq2’s median‑of‑ratios size‑factor method was used and is appropriate here—no extra external scaling is needed. For Tn‑seq, standard RNA‑seq normalization is often not ideal because insertion counts violate the same assumptions; Tn‑seq is better normalized by insertion density, library saturation, or windowed read depth (the windowed RPKM-style approach used in the published method is one example).

To improve statistical power: increase biological replication and sequencing depth, remove very low‑count genes before testing (for example, baseMean < 5), improve RNA quality to reduce technical noise, and use paired designs if appropriate. For Tn‑seq specifically, use methods that are designed for insertion data (windowed approaches or Tn‑seq tools) rather than treating sparse insertion counts like RNA‑seq.

### Tn‑seq essential genes in serum
How the Tn‑seq data were generated and what they represent
The authors grew a high‑density transposon insertion library in BH medium and in human serum, sequenced the insertion junctions, and counted insertions across the genome. This produces fitness data (insertion counts per position or per window), not expression data. The published analysis summarized counts in genomic windows (RPKM-style) and used that to infer essentiality.

The goal is to find genes whose disruption reduces survival in serum. Genes that show depletion of insertions (lower RPKM or negative log2 fold change in serum versus BH) are candidate conditionally essential genes for growth in human serum.

From the DESeq2-based Tn‑seq table, the most convincing depleted candidates are AENJPLPP_00059 and AENJPLPP_00562 (negative log2FC, padj near or below 0.1). These loci show reduced insertion counts in serum and therefore stand out as putative serum‑fitness genes. The RPKM windowed data support depletion of genes involved in DNA repair, stress responses, and central metabolism—pathways that commonly matter for survival in hostile environments like human serum.

### Conclusion
The RNA‑seq results point to modest transcriptional remodeling between BH and serum but are limited by low counts and replication; DESeq2 normalization is appropriate for the RNA‑seq data, while Tn‑seq benefits from insertion‑aware normalization. Tn‑seq highlights a small set of candidate serum‑essential genes (notably AENJPLPP_00059 and AENJPLPP_00562) that merit validation and re‑analysis with Tn‑seq–specific methods and higher depth or replication.
