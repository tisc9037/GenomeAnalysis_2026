#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 05:30:00
#SBATCH -J Hybrid_Assembly_Spades_5kb

module load seqkit

PACBIO_DIR=$1
OUTPUT_DIR=$2


# Combine PacBio reads
PACBIO_COMBINED="$OUTPUT_DIR/pacbio_combined.fastq.gz"
cat "$PACBIO_DIR"/*.fastq.gz > "$PACBIO_COMBINED"

# Keep only reads >= 5 kb
PACBIO_5KB="$OUTPUT_DIR/pacbio_5kb.fastq.gz"
seqkit seq -m 2000 "$PACBIO_COMBINED" -o "$OUTPUT_DIR"

