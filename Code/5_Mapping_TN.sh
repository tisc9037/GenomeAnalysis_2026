#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J TN_mapping

module load BWA/0.7.19-GCCcore-13.3.0 SAMtools/1.22.1-GCC-13.3.0

REF=$1
READ_DIR=$2
OUT_DIR=$3

# Index reference (only needed once)
bwa index "$REF"

for R1 in "$READ_DIR"*_pass.fastq.gz; do
    [ -e "$R1" ] || continue

    SAMPLE=$(basename "$R1" | sed 's/_pass.fastq.gz//')
    OUT="$OUT_DIR/${SAMPLE}.bam"

    echo "TN-seq sample detected: $SAMPLE"
    bwa mem -t 4 "$REF" "$R1" | samtools sort -o "$OUT"
    samtools index "$OUT"
done