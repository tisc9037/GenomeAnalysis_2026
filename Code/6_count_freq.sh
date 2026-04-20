#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 04:00:00
#SBATCH -J HTSeq_auto

module load HTSeq/2.1.2-gfbf-2024a

BAM_DIR=$1
GFF=$2
OUT_DIR=$3

for BAM in "$BAM_DIR"*.bam; do
    SAMPLE=$(basename "$BAM" .bam)
    OUT="$OUT_DIR${SAMPLE}.counts"

    echo "Counting: $SAMPLE"

    htseq-count \
        -f bam \
        -r pos \
        -s no \
        -t gene \
        -i ID \
        "$BAM" \
        "$GFF" > "$OUT"
done

