# Genome Assembly
## Goal
The goal of the genome assembly step is to determine which assembly approach produces the most complete, accurate, and useful reconstruction of the genome. For downstream analyses such as annotation, comparative genomics, and variant analysis, the best assembly is usually the one that combines high completeness with low error rates and good contiguity.

## Results
### Assembly quality
Among the tested assemblies, the PacBio_Canu assembly appears to be the best overall choice. It has the highest genome fraction, or is essentially tied for the highest, while also showing much better accuracy than the Nanopore-based assemblies.

The mismatch rate is substantially lower in PacBio_Canu than in the other assemblies, which suggests that the sequence is more reliable at the base level. In addition, it has no misassemblies, whereas the other assemblies contain many, which is important because structural errors can affect gene order, synteny, and any analysis that depends on genome context.

Contiguity also supports this choice. PacBio_Canu has only 9 contigs and a strong NA50, indicating that the genome is assembled into relatively large and continuous fragments. By comparison, the Nanopore assembly is much more fragmented and therefore less suitable as a primary reference.

PacBio_Flye shows a similar level of completeness, but its higher mismatch rate and large number of misassemblies make it less trustworthy than PacBio_Canu. The Nanopore assemblies perform worse overall, both in terms of fragmentation and sequence errors, so they are less suitable for downstream work.

### Why PacBio
PacBio reads are a strong choice here because they provide a good balance between read length and accuracy. That makes them especially useful for assembling bacterial genomes, where the aim is often to recover one complete chromosome with minimal fragmentation.

Canu is also well suited to PacBio data because it includes read correction and assembly strategies designed for long reads. This improves the quality of the resulting assembly and helps explain why PacBio_Canu performs better than the Nanopore assemblies in this dataset.

## Questions 4
The assembly reports provide several useful quality metrics, including the number of contigs, total assembly length, N50, genome fraction, misassemblies, and base-level error rates. In this case, the PacBio_Canu assembly is clearly more contiguous than the Nanopore assembly, with only 9 contigs compared with 285, which indicates that it is much less fragmented and therefore more useful for most downstream analyses.

Several steps contribute to the final quality of an assembly. Read correction is one of the most important, because it reduces sequencing errors before assembly begins. After that, the assembler identifies overlaps, builds the assembly graph, resolves repeats, and often performs polishing. These steps matter especially for long-read data, since PacBio and Nanopore reads contain more sequencing errors than Illumina reads.

For a bacterial genome, one would normally expect a single circular chromosome or at least only a small number of contigs. From that perspective, the PacBio_Canu assembly is much closer to the expected result than the Nanopore assembly. Differences between assemblers are also expected, because they use different algorithms and error models and handle repeats differently.

K-mers are short DNA sequences of length k that are widely used in genome assembly. Smaller k-mers are more sensitive and can help connect low-coverage regions, but they also increase the chance of false matches. Larger k-mers are more specific and can help resolve repeats, but they require better coverage and are more affected by sequencing errors.

Read correction is a preprocessing step that improves sequence accuracy by comparing overlapping reads and correcting likely mistakes. This is especially important for long-read data, because it improves overlap detection and reduces fragmentation in the final assembly.

When compared with the reference assembly, the student assemblies differ in ways that can be explained by repeats, sequencing errors, collapsed regions, and possible misassemblies. The PacBio_Canu assembly has better contiguity and a higher genome fraction, but the presence of some misassemblies means that continuity alone does not guarantee correctness. The Nanopore assembly is more fragmented and less complete, so it is clearly weaker overall. In short, PacBio_Canu is the strongest assembly for downstream analysis.

## Additional Analysis
The assemblies generated from Illumina, Nanopore, and hybrid data were evaluated with QUAST. The Illumina assembly showed good completeness, while the Nanopore assembly was highly incomplete and therefore not ideal for downstream use. The hybrid assembly improved on both by combining the accuracy of short reads with the long-range information of long reads.

Contiguity metrics followed the same pattern. The Nanopore assembly had the smallest largest contig, Illumina was better, and the hybrid assembly produced the most continuous result overall. This demonstrates the advantage of using long reads to span repeats while still retaining the accuracy of short-read data.

In terms of accuracy, the Illumina and hybrid assemblies aligned well to the reference and showed duplication ratios close to 1, which suggests that they are relatively reliable. The Nanopore assembly aligned much more poorly, which is consistent with a higher error rate and lower assembly quality.

Comparison with the expected genome size also supports this interpretation. The Illumina and hybrid assemblies are close to complete, while the Nanopore-only assembly is clearly too short and incomplete. Overall, the hybrid assembly is the best balanced option, but if the comparison is restricted to the assemblies listed above, PacBio_Canu is the strongest long-read-only assembly.
