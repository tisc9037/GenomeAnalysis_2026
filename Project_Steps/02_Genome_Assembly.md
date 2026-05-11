# Genome Assembly
## Goal
The goal of genome assembly is to reconstruct the most complete, accurate, and contiguous representation of the target genome from sequencing reads. The optimal assembly balances high completeness (genome fraction), low error rates (mismatches, misassemblies), and good contiguity (few contigs, high N50), making it suitable for downstream analyses like annotation, variant calling, and comparative genomics.

## Results
PacBio_Canu stands out as the best assembly. It achieves the highest genome fraction (~85%, tied with PacBio_Flye), but excels with dramatically better accuracy (20.7 mismatches per 100 kbp vs 300–400+ in others) and perfect structural correctness (0 misassemblies vs 72–184 in competitors). Its contiguity is also excellent—only 9 contigs, NA50 of 153 kb, and largest contig of 2.76 Mb.

PacBio_Flye matches completeness but suffers from high error rates and numerous misassemblies. Nanopore assemblies lag in completeness, contiguity, and accuracy across the board. For bacterial genomes expecting near-complete chromosomes, PacBio_Canu's metrics make it the clear primary reference.

### Key quality metrics from assembly reports:
- PacBio_Canu: 9 contigs (vs 285 in Nanopore), superior N50, highest genome fraction
- Structural errors matter: Misassemblies disrupt gene context and synteny
- Assembly pipeline: Read correction → overlap detection → graph construction → repeat resolution → polishing
- PacBio reads excel here due to their length-accuracy balance, while Canu's PacBio-optimized correction explains its edge over Nanopore assemblies.

## Additional Analysis
QUAST evaluation of Illumina, Nanopore, and hybrid assemblies reinforces these patterns. Illumina achieved ~81.6% completeness but limited contiguity. Nanopore was severely incomplete (~6.8%) with poor metrics across the board. Hybrid assemblies combined short-read accuracy with long-read span, producing the most balanced result.

Core takeaway: PacBio_Canu provides the strongest foundation for downstream work. If short reads are available, polishing with Pilon/Racon would further enhance base-level accuracy, though it's already superior to alternatives as-is.
