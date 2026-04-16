#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:15:00
#SBATCH -J Annotation_Prokka

module load prokka/1.14.5-gompi-2024a


INPUT_FILE=$1
OUTPUT_DIR=$2

prokka \
  --genus Enterococcus \
  --species faecium \
  --strain unknown \
  --usegenus \
  --outdir $OUTPUT_DIR \
  --prefix Efaecium \
  $INPUT_FILE
