#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 15:00:00
#SBATCH -J Annotation_NOG

module load eggnog-mapper/2.1.13-gfbf-2024a

INPUT_FASTA=$1
OUTPUT_DIR=$2

emapper.py \
  -i $INPUT_FASTA \
  -o Efaecium_eggnog \
  --output_dir $OUTPUT_DIR \
  --cpu 2 \
  --itype genome \
  --tax_scope Enterococcus \
  --target_orthologs all \
  --go_evidence non-electronic \
  --decorate_gff yes
