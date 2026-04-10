#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:30:00
#SBATCH -J Illumina_Assembly_Spades

# Load modules SPAdes/4.2.0-GCC-13.3.0

# Check arguments
INPUT_DIR=$1
OUTPUT_DIR=$2

# Automatically detect paired-end files
R1=$(ls "$INPUT_DIR"/*_1_*.fq.gz | head -n 1)
R2=$(ls "$INPUT_DIR"/*_2_*.fq.gz | head -n 1)

echo "Using:"
echo "R1 = $R1"
echo "R2 = $R2"
echo "Output = $OUTPUT_DIR"

# Run SPAdes
spades.py  -1 "$R1" -2 "$R2" -o "$OUTPUT_DIR"






