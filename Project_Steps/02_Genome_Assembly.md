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
### Genome and Metagenome Assembly 
1. What information can you get from the plots and reports given by the assembler (if you get any)? 
2. What intermediate steps generate informative output about the assembly?
3. How many contigs do you expect? How many do you obtain? 
4. Do you expect the same result between different assemblers, for the same data? If you tried different assemblers, what differences do you see in the result and why do you think that is?
5. What are the k-mers? What are the problems and benefits of choosing a small or a large k-mer? 
6. Some assemblers can include a read-correction step before doing the assembly. What is this step doing? 

### Assembly evaluation 
1.  How does your assembly compare with the reference assembly? What could have caused the differences?
2.  Do you think your assembly is better/worse than the public one? 


## Additional Analysis
### Genome assembly with Nanopore and Illumina reads
1.	Which assembly is more suitable for downstream analyses? Why?
2.	What is the size of the largest contig of each assembly?
3.	Which assembly do you think is more accurate?
4.	Compare total assembly length to known/expected genome size. 

