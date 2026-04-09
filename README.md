# GenomeAnalysis_2026


## Project Planning
This project is a redo of the “RNA-seq and Tn-seq reveal fitness determinants of vancomycin-resistant Enterococcus faecium during growth in human serum” research done in 2017 by Xinglin Zhang, et al. 
Doi: 10.1186/s12864-017-4299-9

The aim of this project is to identify genes related to the growth of Enterococcus faecium in humans. As it has acquired resistance to multiple antibiotics it is important to find new medication. The genetic mechanism within E. Faecuim were before this study not yet identified, and thus interesting to investigate. By using different techniques to analyse the RNA-seq and Tn-seq data from this study I will hopefully be able to identify the genes active in the growth in human serum. And ofcourse get the credits for this course ;).
 
### Data quality and preprocessing
Because analysis and models are always as good to the worst input data it is important to start by doing a data quality assessment. To assist in this FastQC will be used. Based on these results it will be evaluated to with what extend data preprocessing is needed.  
The preprocessing process will be streamlined by using Trimmomatic, which is a fast multithreaded program that can be used to remove adapters and trim and crop fastq data.

### Genome and metagenome assembly
When the data is ready genome and metagenome assembly will be done. Because there is data from PacBio reads, as well as illumina and Nanopore reads extra analysis will be done to find out which of these methods is best suited for downstream analysis. To assemble the RNA-seq data Trinity will be used, and for the Tn-seq data Flye will be used as it can be used for small bacterial genomes. 
The evaluation of the assembly will be done in multiple steps, or multiple times depending how you look at it. To start QUAST will be used to be able to independently evaluate the quality, on top of this (or after) the alignment will be compared to the one done in the original research.

### Annotation
The next step will be to find the genetic elements. This will be done by using Prokka to add biochemical functions to prokaryotic genomes. Furthermore, EggNOGmapper will be used to further investigate the functional predictions.

### Homology search Mapping and analysis
To be able to assess the quality of the assembly a comparison with reference model can be done. To actually find this reference genome Blastn will be run. This then will be used to determine mistakes and read coverage using BWA. Finally, to do some file manipulation SAMtools will be used.  
Here I also wish to do a plasmid identification if the time is there.

### Expression
At this point the expressed genes can be counted. This will be done using a python package called HTSeq. This will be done for the in human serum and control so they can be compared.
Because assessing the difference between the two situations can not just be done by eye, DESeq2 will be used to do a statistical analysis. DESeq2 is a R package used to estimate variance-mean dependence. This test then can used to identify the essential genes for growth in human serum.

### Visualisation of the genomes
Because I have to but also because I am a visually oriented person, Artemis Comparison Tool (ACT) will be used. This is a visualisation tool designed for pairwise comparison, which is great to compare the genome in control and in human serum.



## planning
•	10/4: project plan finished, data organized, software installed, and folders/scripts ready.

•	16/4: primary genome assembly finished, so I can move to evaluation and refinement.

•	21/4: assembly evaluation finished and the genome is stable enough for annotation.

•	28/4: structural/functional annotation finished.

•	5/5: comparative genomics/synteny finished.

•	8/5: RNA-seq trimming finished.

•	11/5: RNA mapping finished.

•	13/5: read counting finished.

•	19/5: differential expression finished.

•	22/5: all results are interpreted and written up for the wiki.

•	26/5: final presentation ready.


	
## Data constancy and needs


### Data orginization
I personally like a lot of folders with clear separations between analysis. And old versions backed up in a different folder then the up-to-date files. Furthermore a GitHub depository will be used for additional version control.


