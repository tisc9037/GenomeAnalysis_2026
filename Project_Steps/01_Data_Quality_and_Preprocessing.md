# Data Quality
## Goal
rRaw reads should always be assessing on their quality before analyses. Trim or remove low‑quality regions and adapter sequences if needed, and then perform a second quality check to ensure all issues are resolved before continuing with downstream analyses.

## Results

<insert example fastqc PacBio>
<insert example fastqc Illumina>

### Reads quality control 
1. How is the quality of your data?

Illumina: Great
PacBio: as expected for CLR reads from this time

3. What can generate the “fails” in FastQC that you observe in your data? Can these cause any problems during subsequent analyses?

These can just be explained by the fact that FastQC is not ment for PacBio CLR reads. but this does not mean that there are problems for the long term analyses.

### Reads preprocessing 
4. How many reads have been discarded after trimming?
6. How can this affect your future analyses and results? 
7. How is the quality of your data after trimming? 
8. What quality threshold did you choose for the leading/trailing/slidingwindow parameters, and why?

This part was not really a thing for me as i descided that the Illumina was good enouigh and Trimmomatic is not ment for PacBio data.
Canu also does this itself:
<insert example Canu>
