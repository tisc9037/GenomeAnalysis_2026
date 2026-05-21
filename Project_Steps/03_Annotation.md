# Annotation
## Goal
The aim of the functional annotation is to assign biological meaning to the predicted genes in the assembled contigs and to assess how well the genome content is represented. In practice, this involves identifying gene types, evaluating functional assignments, and determining whether key biological features are captured.

## Results
The Prokka annotation identifies a wide range of features, including protein-coding genes, tRNAs, rRNAs, and functionally annotated proteins. The dataset contains enzymes, transporters, regulators, ribosomal proteins, and proteins associated with mobile genetic elements. Many genes have specific functional names supported by database matches, while others remain annotated as hypothetical proteins or general protein families.

The presence of conserved housekeeping genes indicates that the annotation captures the core biological functions of the genome. At the same time, a substantial number of hypothetical proteins and transposase-related genes are observed, which is common in bacterial genomes, especially in regions influenced by recombination or horizontal gene transfer.

The annotation clearly identifies the vancomycin-resistance locus, including genes such as vanR, vanH, and vanB. These genes are located on different contigs, suggesting that the region is fragmented in the assembly. Despite this fragmentation, the key resistance genes are present and can be reliably detected.

### Annotation Quality
The overall annotation quality is supported by the number of genes with specific functional assignments, including gene names, EC numbers, and conserved protein family annotations. The recovery of core bacterial genes, structural RNAs, and resistance-associated genes indicates that the annotation is biologically consistent and informative.
The presence of many hypothetical proteins does not necessarily indicate poor annotation quality. Instead, it reflects the limitation of current databases, where some predicted proteins lack strong similarity to characterized sequences. This is a common outcome in bacterial genome annotation.

### Additional Analysis
The eggNOG results provide additional functional context by linking proteins to orthologous groups, GO terms, KEGG identifiers, and pathway information. This adds confidence to the functional assignments, particularly for genes already annotated by Prokka.
For the vancomycin-resistance region, the eggNOG annotations support the interpretation that these genes belong to a known resistance module rather than unrelated enzyme classes. Combined with the Prokka results, this indicates that the strain carries a vancomycin-resistance locus located in a mobile-element-rich region of the genome.
