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

# Detect PacBio reads (fastq or fq, gzipped or not)
PACBIO_READS=$(ls "$INPUT_DIR"/*.subreads.fastq.gz 2>/dev/null)

# Run Flye
flye --pacbio-hifi $PACBIO_READS --out-dir "$OUTPUT_DIR" --threads $SLURM_CPUS_PER_TASK

