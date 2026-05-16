# Genome Assembly
## Goal
The goal of genome assembly is to reconstruct the most complete, accurate, and contiguous representation of the target genome from sequencing reads. The best assembly balances high completeness, low error rates, and strong contiguity, so it can serve as a reliable foundation for downstream analyses such as annotation, variant calling, and comparative genomics.

## Results
Among the assemblies evaluated, PacBio_Canu is the strongest overall choice. It has the highest genome fraction at 85.0% and produces a single dominant contig of about 2.58 Mb, which points to excellent long-range reconstruction. The reported structural misassemblies are worth noting, but the assembly still shows the best combination of completeness and contiguity compared with the other options.

The Illumina-only assembly reaches 81.6% genome fraction, but it is highly fragmented and therefore less useful as a primary reference. The Nanopore-only assembly performs much more poorly, with only 6.8% genome fraction and very limited contig structure. The hybrid Illumina+Nanopore assembly improves both completeness and contiguity, but it still shows structural inconsistency and is less coherent than PacBio_Canu overall.

For a bacterial genome, where a near-complete chromosome is usually expected, PacBio_Canu gives the most convincing reconstruction. Its long, accurate reads give Canu a clear advantage in resolving larger genomic segments and producing a more usable assembly for downstream work.

## Additional Analysis
The QUAST results support the same conclusion. The Illumina assembly has reasonable base accuracy but lacks long-range continuity, while the Nanopore assembly is too incomplete to be a strong candidate. The hybrid assembly sits between those extremes, combining some advantages of both technologies, but it remains structurally noisier than the PacBio-based assembly.

In practical terms, the main takeaway is that PacBio_Canu is the most reliable foundation for later analyses. If short reads are available, polishing with a tool such as Pilon or Racon could further improve base-level accuracy, but even without extra polishing, PacBio_Canu remains the best assembly in this set.
