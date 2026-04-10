#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:30:00
#SBATCH -J Illumina_Assembly_Spades

# Load modules SPAdes/4.2.0-GCC-13.3.0

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: sbatch assembly_spades.sh <input_dir> <output_dir>"
    exit 1
fi

INPUT_DIR=$1
OUTPUT_DIR=$2

# Automatically detect paired-end files
R1=$(ls "$INPUT_DIR"/*R1*.fastq.gz | head -n 1)
R2=$(ls "$INPUT_DIR"/*R2*.fastq.gz | head -n 1)

# Check files found
if [ ! -f "$R1" ] || [ ! -f "$R2" ]; then
    echo "Could not find paired-end FASTQ files in $INPUT_DIR"
    exit 1
fi

echo "Using:"
echo "R1 = $R1"
echo "R2 = $R2"
echo "Output = $OUTPUT_DIR"

# Run SPAdes
spades.py \
    --careful \
    -1 "$R1" \
    -2 "$R2" \
    -o "$OUTPUT_DIR" \
    -t 8module load SPAdes/4.2.0-GCC-13.3.0






