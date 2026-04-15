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


# Loop over R1 files only
find "$IN_DIR" -type f -name "*_1_clean.fq.gz" | while read R1; do
    # Infer R2
    R2="${R1/_1_clean.fq.gz/_2_clean.fq.gz}"

    # Base name without _1.fastq.gz
    base=$(basename "$R1" _1_clean.fq.gz)

    # Run Trimmomatic
    trimmomatic PE -threads 1 -phred33 \
        "$R1" "$R2" \
        "$OUT_DIR/${base}_1_paired.fq.gz" \
        "$OUT_DIR/${base}_1_unpaired.fq.gz" \
        "$OUT_DIR/${base}_2_paired.fq.gz" \
        "$OUT_DIR/${base}_2_unpaired.fq.gz" \
        SLIDINGWINDOW:4:20 \
        MINLEN:36
done

