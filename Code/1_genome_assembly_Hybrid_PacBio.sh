#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 05:30:00
#SBATCH -J Hybrid_Assembly_Spades

module load SPAdes/4.2.0-GCC-13.3.0

INPUT_DIR=$1
PACBIO_DIR=$2
ALLIGNED_PACBIO=$3
OUTPUT_DIR=$4

# Detect Illumina reads
R1=$(ls "$INPUT_DIR"/*_1_clean.fq.gz | head -n 1)
R2=$(ls "$INPUT_DIR"/*_2_clean.fq.gz | head -n 1)

# Detect PacBio reads
PACBIO_COMBINED="$OUTPUT_DIR/pacbio_combined.fastq.gz"
cat "$PACBIO_DIR"/*.fastq.gz > "$PACBIO_COMBINED"


spades.py -1 "$R1" -2 "$R2" \
	--pacbio "$PACBIO_COMBINED" \
	--trusted-contigs "$ALLIGNED_PACBIO" \
	--isolate -o "$OUTPUT_DIR"/trusted/


spades.py -1 "$R1" -2 "$R2" \
	--pacbio "$PACBIO_COMBINED" \
	--untrusted-contigs "$ALLIGNED_PACBIO" \
	--isolate -o "$OUTPUT_DIR"/untrusted/
