# Genome Assembly


## Results
why is used PacBio for the rest.

Why PacBio_Canu is the best choice
Coverage/completeness: Highest genome fraction (~85%), essentially tied with PacBio_Flye but clearly better than both Nanopore assemblies.

Accuracy: By far the lowest mismatch rate (20.7 vs 300–400+ per 100 kbp in others).

Structural correctness: 0 misassemblies vs 72–184 in the others—this is huge for downstream analyses like variant calling, gene context, synteny, etc.

Contiguity: Very strong NA50 (153 kb) with only 9 contigs and a largest contig of ~2.76 Mb.

PacBio_Flye has similar completeness but is riddled with misassemblies and much higher mismatch rate. Both Nanopore assemblies are clearly inferior on completeness, contiguity, and/or error rates.

Practical recommendation
Use PacBio_Canu as your primary assembly for downstream analysis.

If you have short reads, consider polishing it (e.g., with Pilon, Racon, etc.), but even as is, it’s the best foundation by a wide margin.

If you tell me what “downstream” means for you (variant calling, annotation, comparative genomics), I can suggest specific polishing/cleanup steps tailored to that.


## Questions 4
The assembly reports provide several key metrics that are useful for evaluating assembly quality, including the number of contigs, total assembly length, N50, genome fraction, misassemblies, and base-level errors. In this case, the Canu PacBio assembly is considerably more contiguous than the NanoPore assembly, with only 9 contigs and a much higher N50, whereas the NanoPore assembly contains 285 contigs and is therefore substantially more fragmented.

A number of intermediate steps contribute to the final quality of a genome assembly. One of the most important is read correction, in which sequencing errors are reduced before assembly begins. This is followed by overlap detection, graph construction, repeat resolution, and often polishing. These steps are especially important for long-read data, since PacBio and Nanopore reads typically contain higher error rates than Illumina reads.

For a bacterial genome, one would generally expect a single circular chromosome or only a small number of contigs. From that perspective, the Canu result is closer to the expected outcome than the NanoPore assembly. Differences between assemblers are also expected, since they rely on different algorithms, error models, and strategies for handling repeats and sequencing errors.

K-mers are short subsequences of length k, that are used extensively in genome assembly. Smaller k-mers are more sensitive and can improve connectivity in low-coverage regions, but they may also increase the risk of false matches. Larger k-mers are more specific and can help resolve repeats, although they require higher coverage and are more affected by sequencing errors.

Read correction is a preprocessing step designed to improve sequence accuracy before assembly. It uses agreement among overlapping reads to identify and correct likely errors, which improves overlap detection and reduces fragmentation in the final assembly.

When compared with the reference assembly, both of the student assemblies show differences that may be explained by repeats, sequencing errors, collapsed regions, or misassemblies. The Canu assembly shows better contiguity and a higher genome fraction, but it also contains a notable number of misassemblies, so higher continuity does not necessarily imply higher correctness. The NanoPore assembly is more fragmented and less complete, which suggests lower overall assembly quality. Overall, the Canu assembly appears stronger in terms of contiguity, while the public assembly is likely superior in terms of curation and accuracy.


## Additional Analysis
Assemblies generated from Illumina, Nanopore, and hybrid (Illumina + Nanopore) data were evaluated using QUAST. The Illumina assembly showed high completeness (~81.6% genome fraction), whereas the Nanopore assembly was highly incomplete (~6.8%), making it unsuitable for downstream analyses. The hybrid assembly improved upon both, combining high completeness with better contiguity.

Contiguity metrics reflected this trend: the Nanopore assembly had the smallest largest contig (~23 kb), Illumina was higher (~114 kb), and the hybrid assembly produced the most continuous assembly overall. This demonstrates the advantage of integrating long reads to span repeats while maintaining short-read accuracy.

In terms of accuracy, the Illumina and hybrid assemblies both showed high aligned lengths (~2.3–2.4 Mb) and near-ideal duplication ratios (~1.0), whereas the Nanopore assembly aligned poorly (~0.19 Mb), consistent with higher sequencing error rates.

Comparison to the expected genome size (~2–2.5 Mb) further confirmed that both Illumina and hybrid assemblies were near-complete, while the Nanopore assembly was substantially shorter and incomplete.

In conclusion, the hybrid assembly is the most suitable overall, as it combines the accuracy of Illumina reads with the structural advantages of Nanopore long reads, while the Nanopore-only assembly performs poorly.
