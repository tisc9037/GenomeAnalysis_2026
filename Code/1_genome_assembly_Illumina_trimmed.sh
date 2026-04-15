#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:30:00
#SBATCH -J Illumina_Assembly_Spades

# Load modules 
module load SPAdes/4.2.0-GCC-13.3.0

# Check arguments
INPUT_DIR=$1
OUTPUT_DIR=$2

# Automatically detect paired-end files
R1_p=$(ls "$INPUT_DIR"*_1_paired.fq.gz | head -n 1)
R2_p=$(ls "$INPUT_DIR"*_2_paired.fq.gz | head -n 1)

# Run SPAdes with both paired and unpaired reads
spades.py \
  -1 "$R1_p" \
  -2 "$R2_p" \
  --isolate \
  -o "$OUTPUT_DIR"
