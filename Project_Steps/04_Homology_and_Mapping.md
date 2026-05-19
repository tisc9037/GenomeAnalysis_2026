# Homology and Mapping
## Goal
The goal of this analysis is to evaluate the mapping efficiency and distribution of sequencing reads against the assembled contigs. By calculating the percentage of mapped reads and analyzing coverage across the genome, we can assess the completeness of the assembly, identify potential contamination or biological differences, and ensure that the assembly is a reliable foundation for downstream analyses.

## Results
### Homology
<table>
  <tr>
    <th>ACT PacBio Allignment vs NCBI</th>
  </tr>
  <tr>
    <td><img src="../Plots/ACT.png" width="350"></td>
  </tr>
</table>

### Mapping
The mapping rate is fairly high for the BH samples, with approximately 81–84% of reads mapping back to the contigs. In contrast, the Serum samples show significantly lower mapping rates, ranging from 48–62%. This suggests that the BH dataset aligns much more effectively with the assembly than the Serum dataset. The lower mapping efficiency in the Serum samples may be due to higher biological diversity, the presence of non-target DNA, or greater structural divergence between those reads and the reference contigs.

Variations in read coverage often highlight regions that are more or less conserved, as well as repetitive areas that are difficult to map uniquely. High coverage areas typically represent well-assembled regions, whereas lower coverage may indicate sequencing bias, structural variations, or highly complex genomic regions. In bacterial genomes, these differences can also point to differential gene expression or variations in gene copy numbers between samples.

The replicates remain consistent within their respective experimental groups. The BH samples show tight clustering in their mapping percentages, and while the Serum samples show slightly more variability, they remain comparable to one another. The fact that the differences are more pronounced between the BH and Serum groups than between individual replicates suggests that the patterns are driven by distinct biological responses rather than technical inconsistencies.
