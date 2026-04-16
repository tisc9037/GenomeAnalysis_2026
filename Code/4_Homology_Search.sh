#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J BlastN

module load BLAST+/2.17.0-gompi-2024a

INPUT_FILE=$1
DB=$2
OUTPUT_DIR=$3

# Run BLASTN homology search
blastn \
    -query "$INPUT_FILE" \
    -db "$DB" \
    -out ""$OUTPUT_DIR"blast_results.tsv" \
    -outfmt 6 \
    -evalue 1e-5 \
    -num_threads 1

