#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:00:00
#SBATCH -J RNAseq_Trimming_PE_only

module load bioinfo-tools
module load FastQC
module load Trimmomatic

IN_DIR="$1"
OUT_DIR="$2"

RAW_QC="$OUT_DIR/fastqc_raw"
TRIM_DIR="$OUT_DIR/trimmed"
TRIM_QC="$OUT_DIR/fastqc_trimmed"

mkdir -p "$RAW_QC" "$TRIM_DIR" "$TRIM_QC"

echo "=== Running FastQC on raw reads ==="

find "$IN_DIR" -type f -name "*_1.fastq.gz" | while read R1; do
    R2="${R1/_1.fastq.gz/_2.fastq.gz}"
    fastqc -o "$RAW_QC" "$R1" "$R2"
done

echo "=== Running Trimmomatic (paired-end only) ==="

find "$IN_DIR" -type f -name "*_1.fastq.gz" | while read R1; do
    R2="${R1/_1.fastq.gz/_2.fastq.gz}"
    base=$(basename "$R1" _1.fastq.gz)

    trimmomatic PE -threads 1 -phred33 \
        "$R1" "$R2" \
        "$TRIM_DIR/${base}_1_paired.fq.gz" \
        /dev/null \
        "$TRIM_DIR/${base}_2_paired.fq.gz" \
        /dev/null \
        ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10 \
        SLIDINGWINDOW:4:20 \
        MINLEN:36
done

echo "=== Running FastQC on trimmed paired reads ==="

find "$TRIM_DIR" -type f -name "*_1_paired.fq.gz" | while read R1; do
    R2="${R1/_1_paired.fq.gz/_2_paired.fq.gz}"
    fastqc -o "$TRIM_QC" "$R1" "$R2"
done

echo "=== All done! ==="
