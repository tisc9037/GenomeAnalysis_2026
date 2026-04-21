#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J RNA_mapping

module load BWA/0.7.19-GCCcore-13.3.0 SAMtools/1.22.1-GCC-13.3.0

REF=$1 
READ_DIR=$2
OUT_DIR=$3

# Index reference (only needed once)
bwa index "$REF"

#PAIRED
for R1 in "$READ_DIR"*_paired_*_pass_1.fastq.gz; do
    [ -e "$R1" ] || continue

    SAMPLE=$(basename "$R1" | sed 's/_paired_/_/; s/_pass_1.fastq.gz//')
    R2="${R1/_pass_1.fastq.gz/_pass_2.fastq.gz}"
    OUT="$OUT_DIR${SAMPLE}_paired.bam"

    echo "Paired-end detected: $SAMPLE"
    bwa mem -t 4 "$REF" "$R1" "$R2" | samtools sort -o "$OUT"
    samtools index "$OUT"
done


#SINGLE
for R1 in "$READ_DIR"*_single_*_pass_1.fastq.gz; do
    [ -e "$R1" ] || continue

    SAMPLE=$(basename "$R1" | sed 's/_single_/_/; s/_pass_1.fastq.gz//')
    OUT="$OUT_DIR${SAMPLE}_single.bam"

    echo "Single-end detected: $SAMPLE"
    bwa mem -t 4 "$REF" "$R1" | samtools sort -o "$OUT"
    samtools index "$OUT"
done
