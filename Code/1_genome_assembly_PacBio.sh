#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 16
#SBATCH -t 05:30:00
#SBATCH -J PacBio_Assembly_Flye

# Load Flye
module load Flye/2.9.6-GCC-13.3.0

# Check arguments
INPUT_DIR=$1
OUTPUT_DIR=$2

# Detect PacBio reads (fastq or fq)
PACBIO_READS=$(ls "$INPUT_DIR"/*.subreads.fastq.gz)

# Run Flye
flye --pacbio-raw $PACBIO_READS --out-dir "$OUTPUT_DIR" --threads 32

