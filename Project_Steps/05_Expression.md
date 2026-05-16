# Expression
## Goal
The goal of this analysis is to examine the distribution of read counts per gene and determine how many genes are expressed in the BH (control)and Serum samples. This helps identify whether most genes receive enough reads to be considered expressed and gives a sense of the overall expression profile in each condition.

## Results
The count distributions for both BH and Serum are strongly right-skewed, with many genes having low counts and a smaller set of genes showing much higher expression . In both samples, the majority of genes appear to have non-zero counts, so most genes are expressed to some extent, although many are only weakly expressed .

A practical threshold for considering a gene expressed is usually at least a small number of mapped reads, often around 10 counts or more, depending on the downstream analysis. In these histograms, genes below that level make up the low-expression tail, while genes above it are more likely to represent robust expression .

The BH sample shows a slightly broader and more strongly populated high-count region, suggesting that more genes are expressed at moderate to high levels compared with the Serum sample . The Serum distribution is similar overall, but it appears somewhat more shifted toward lower counts and has a longer low-expression tail .
