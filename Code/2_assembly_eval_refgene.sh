#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:15:00
#SBATCH -J Assembly_Eval_Refgeb

# Load modules 
module load QUAST/5.3.0-gfbf-2024a

In_File=$1
Ref_File=$2
Out_Dir=$3

quast "$In_File" -r "$Ref_File" -o "$Out_Dir"
