# GenomeAnalysis_2026


## Project Planning
This project is a redo of the “RNA-seq and Tn-seq reveal fitness determinants of vancomycin-resistant Enterococcus faecium during growth in human serum” research done in 2017 by Xinglin Zhang, et al. 
Doi: 10.1186/s12864-017-4299-9

The aim of this project is to identify genes related to the growth of Enterococcus faecium in humans. As it has acquired resistance to multiple antibiotics it is important to find new medication. The genetic mechanism within E. Faecuim were before this study not yet identified, and thus interesting to investigate. By using different techniques to analyse the RNA-seq and Tn-seq data from this study I will hopefully be able to identify the genes active in the growth in human serum. And ofcourse get the credits for this course ;).
 
### Data quality and preprocessing
Because analysis and models are always as good to the worst input data it is important to start by doing a data quality assessment. To assist in this FastQC will be used. Based on these results it will be evaluated to with what extend data preprocessing is needed.  
The preprocessing process will be streamlined by using Trimmomatic, which is a fast multithreaded program that can be used to remove adapters and trim and crop fastq data.

### Genome assembly
When the data is ready genome assembly will be done. Because there is data from PacBio reads, as well as illumina and Nanopore reads an extra analysis will be done to find out which of these methods is best suited for downstream analysis. In this case the NanoPore reads are already assembled, so only the PacBio and Illumina reads need to be assembled. For the Illumina assembly Spades will be used in classic config, in addition for PacBio reads Canu will be used. I do want to try a combination of both as Spades does allow this.
The evaluation of the assembly will be done in multiple steps, or multiple times depending how you look at it. To start QUAST will be used to be able to independently evaluate the quality. As additional analysis, the alignment will be compared to the one done in the original research. The allignment can be found under the name ASM973400v2, and in this step the GCF will be used.

### Annotation
The next step will be to find the genetic elements. This will be done by using Prokka to add biochemical functions to prokaryotic genomes. Furthermore, EggNOGmapper will be used to further investigate the functional predictions.

### Homology search Mapping and analysis
To be able to assess the quality of the assembly a comparison with reference model can be done. To actually find this reference genome Blastn will be run. This then will be used to determine mistakes and read coverage using BWA. Finally, to do some file manipulation SAMtools will be used.  
As additional analysis, I also wish to do a plasmid identification if the time is there.

### Expression
At this point the expressed genes can be counted. This will be done using a python package called HTSeq. This will be done for the in human serum and control so they can be compared.
Because assessing the difference between the two situations can not just be done by eye, DESeq2 will be used to do a statistical analysis. DESeq2 is a R package used to estimate variance-mean dependence. This test then can used to identify the essential genes for growth in human serum.

### Visualisation of the genomes
Because I have to but also because I am a visually oriented person, Artemis Comparison Tool (ACT) will be used. This is a visualisation tool designed for pairwise comparison, which is great to compare the genome in control and in human serum.



## planning
•	10/4: project plan finished, data organized and folders ready.
		  Start of data quality control.

•	15-16/4 genome assembly of Illunina and additional assembly of PacBio.
			And quality control of these assembly.

•	21-24/4: assembly evaluation finished and start annotation.

•	28/4: structural/functional annotation finished.

•	5/5: homology search.

•	8/5: RNA-seq and tn-seq mapping.

•	11-13/5: read counts and expressions analysis.

•	19/5: differential expression.

•	22/5: finalize results and round out the git wiki.

•	26/5: final presentation ready.


	
## Data and Storage
Data constancy and needs
This project will work on raw sequencing reads from the initial article. These are PacBio, Illumina and Nanopore reads, as well as RNA-seq and tn-seq files. During the project extra files like FASTA, FASTQ and BAM files will be created aswell.

### Data types
•	PacBio long reads for the primary genome assembly 

•	Illumina short reads and Nanopore long reads for additional analyses 

•	RNA-seq reads for gene expression analysis 

•	Tn-seq reads for essential gene analyses 

•	Outputs from used tools, including genome FASTA files, GFF annotations, BAM files, count matrices, and result tables 


### Storage requirements
The full datamap contains a total of 35 Gb of data, which is not allot. But this will become significantly more when the analysis go on.

### Data orginization
Initially the raw data will be stored in personal directory. When the data limit gets surpassed a folder within the general project folder will be used.

