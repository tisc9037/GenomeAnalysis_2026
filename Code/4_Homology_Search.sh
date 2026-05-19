#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J BlastN

module load BLAST+/2.17.0-gompi-2024a

INPUT_FILE=$1
reference_fasta=$2
OUTPUT_DIR=$3

blastn \
 -query "$INPUT_FILE" \
 -subject "$reference_fasta" \
 -out ""$OUTPUT_DIR"comparison.crunch" \
 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"