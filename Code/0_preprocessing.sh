#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:15:00
#SBATCH -J run_FastQ

# Load modules
module load FastQC/0.12.1-Java-11

# Your commands
INPUT_DIR=$1
OUTPUT_DIR=$2

fastqc -t 4 -o "$OUTPUT_DIR" "$INPUT_DIR"/*.fastq.gz




