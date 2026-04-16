#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 12:30:00
#SBATCH -J NanoPore_Assembly_Canu

module load canu/2.3-GCCcore-13.3.0-Java-17 SAMtools/1.22.1-GCC-13.3.0

INPUT_FILE=$1
OUTPUT_DIR=$2

# Run Canu
canu \
  -p NanoPore \
  -d "$OUTPUT_DIR" \
  genomeSize=3.2m \
  useGrid=false \
  corOutCoverage=200 \
  minReadLength=1000 \
  -nanopore  "$INPUT_FILE"
