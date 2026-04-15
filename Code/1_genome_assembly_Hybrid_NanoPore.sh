#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 05:30:00
#SBATCH -J Hybrid_Assembly_Spades

module load SPAdes/4.2.0-GCC-13.3.0

INPUT_DIR=$1
ALLIGNED_NP=$2
OUTPUT_DIR=$3

# Detect Illumina reads
R1=$(ls "$INPUT_DIR"/*_1_clean.fq.gz | head -n 1)
R2=$(ls "$INPUT_DIR"/*_2_clean.fq.gz | head -n 1)

spades.py -1 "$R1" -2 "$R2" \
	--trusted-contigs "$ALLIGNED_NP" \
	--isolate -o "$OUTPUT_DIR"
