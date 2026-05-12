#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 08:00:00
#SBATCH -J TNseq_pipeline

module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0
module load BEDTools/2.31.1

REF=$1          # genome fasta
READ_DIR=$2     # directory with *_pass.fastq.gz
OUT_DIR=$3      # output directory
GFF=$4          # Prokka annotation

mkdir -p "$OUT_DIR"/{bam,windows,counts,genes,intersect}

# 1. Index genome
echo "Indexing genome..."
bwa index "$REF"
samtools faidx "$REF"

# 2. Map TN-seq reads
echo "Mapping TN-seq reads..."

for R1 in "$READ_DIR"/*_pass.fastq.gz; do
    [ -e "$R1" ] || continue

    SAMPLE=$(basename "$R1" | sed 's/_pass.fastq.gz//')
    BAM="$OUT_DIR/bam/${SAMPLE}.bam"

    echo "Mapping sample: $SAMPLE"
    bwa mem -t 4 "$REF" "$R1" | samtools sort -o "$BAM"
    samtools index "$BAM"
done

# 3. Create 25-nt genome windows
echo "Creating 25-nt windows..."

bedtools makewindows -g "${REF}.fai" -w 25 \
    > "$OUT_DIR/windows/windows_25nt.bed"

# 4. Prepare gene BED with last 10% removed
echo "Preparing trimmed gene annotation..."

grep -w "gene" "$GFF" | awk -F'\t' '
BEGIN{OFS="\t"} {
    start=$4; end=$5; len=end-start+1;
    cutoff=int(len*0.1);
    new_end=end-cutoff;
    print $1, start-1, new_end, $9
}' > "$OUT_DIR/genes/genes_trimmed.bed"

# 5. Count reads per 25-nt window
echo "Counting reads per window..."

for BAM in "$OUT_DIR"/bam/*.bam; do
    SAMPLE=$(basename "$BAM" .bam)
    bedtools coverage \
        -a "$OUT_DIR/windows/windows_25nt.bed" \
        -b "$BAM" \
        -counts \
        > "$OUT_DIR/counts/${SAMPLE}_25nt_counts.bed"
done

# 6. Intersect windows with trimmed genes
echo "Intersecting windows with genes..."

for FILE in "$OUT_DIR"/counts/*_25nt_counts.bed; do
    SAMPLE=$(basename "$FILE" _25nt_counts.bed)

    bedtools intersect \
        -a "$OUT_DIR/genes/genes_trimmed.bed" \
        -b "$FILE" \
        -wa -wb \
        > "$OUT_DIR/intersect/${SAMPLE}_gene_windows.bed"
done

echo "DONE, woop woop"
