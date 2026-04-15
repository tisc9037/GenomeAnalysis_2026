#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 03:30:00
#SBATCH -J PacBio_Assembly_Canu

module load canu/2.3-GCCcore-13.3.0-Java-17 SAMtools/1.22.1-GCC-13.3.0

INPUT_DIR=$1
OUTPUT_DIR=$2

# Combine all PacBio subreads into one file
PACBIO_COMBINED=""$OUTPUT_DIR"pacbio_combined.fastq.gz"
cat "$INPUT_DIR"*.subreads.fastq.gz > "$PACBIO_COMBINED"

# Run Canu
canu \
  -p pacbio_assembly \
  -d "$OUTPUT_DIR" \
  genomeSize=3m \
  useGrid=false \
  -pacbio-raw "$PACBIO_COMBINED"
