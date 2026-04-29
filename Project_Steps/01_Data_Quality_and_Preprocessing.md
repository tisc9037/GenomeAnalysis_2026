# Data Quality
## Goal
rRaw reads should always be assessing on their quality before analyses. Trim or remove low‑quality regions and adapter sequences if needed, and then perform a second quality check to ensure all issues are resolved before continuing with downstream analyses.

## Results

<insert example fastqc PacBio>
<insert example fastqc Illumina>



## Questions 4

### Reads quality control 
1. How is the quality of your data?
2. What can generate the “fails” in FastQC that you observe in your data? Can these cause any problems during subsequent analyses?
     These can just be explained by the fact that FastQC is not ment for PacBio CLR reads. but this does not mean that there are problems for the long term analyses.

### Reads preprocessing 
4. How many reads have been discarded after trimming? 
5. How can this affect your future analyses and results? 
6. How is the quality of your data after trimming? 
7. What quality threshold did you choose for the leading/trailing/slidingwindow parameters, and why?
