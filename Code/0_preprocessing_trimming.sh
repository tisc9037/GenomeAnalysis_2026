#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 0:50:00
#SBATCH -J run_Trimming

module load Trimmomatic

# Input arguments
IN_DIR="$1"
OUT_DIR="$2"

mkdir -p "$OUT_DIR"

# Loop over R1 files only
find "$IN_DIR" -type f -name "*_1.fastq.gz" | while read R1; do
    # Infer R2
    R2="${R1/_1.fastq.gz/_2.fastq.gz}"

    # Base name without _1.fastq.gz
    base=$(basename "$R1" _1.fastq.gz)

    # Run Trimmomatic
    trimmomatic PE -threads 1 -phred33 \
        "$R1" "$R2" \
        "$OUT_DIR/${base}_1_paired.fastq.gz" \
        "$OUT_DIR/${base}_1_unpaired.fastq.gz" \
        "$OUT_DIR/${base}_2_paired.fastq.gz" \
        "$OUT_DIR/${base}_2_unpaired.fastq.gz" \
        SLIDINGWINDOW:4:20 \
        MINLEN:36
done

