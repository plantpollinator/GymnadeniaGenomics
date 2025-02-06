#!/bin/bash
#SBATCH --job-name="Reas_yak_count"
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --partition=jic-short
#SBATCH --mem 60G
#SBATCH --time=0-02:00
#SBATCH -o /jic/scratch/groups/Matthew-Hartley/kourounr/Gymnadenia_populations/output_error/%x_%A_%a_%N.out
#SBATCH -e /jic/scratch/groups/Matthew-Hartley/kourounr/Gymnadenia_populations/output_error/%x_%A_%a_%N.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rea.antoniou-kourounioti@jic.ac.uk
#SBATCH --array=1#-5

SAMPLES=(RTK3E2_RTK3F2_F1 GcKG13_RTK3F2_F1 GcKG13_RTK3E2_F1)
SAMPLE=${SAMPLES[0]}
echo $SAMPLE

#parameters
ks=(17 27 37 47 57)
k=${ks[$SLURM_ARRAY_TASK_ID-1]}
b=37

pwd
hostname
date

echo -e "\n\n\n"
cat $0
echo -e "\n\n\n"

#SCRIPTS_DIR="/jic/scratch/groups/Matthew-Hartley/paajanep/yak/yak"
SCRIPTS_DIR="/jic/scratch/groups/Matthew-Hartley/kourounr/software/yak"
export PATH=$PATH:$SCRIPTS_DIR

echo $PATH

yak count -k$k -b$b -t32 -o ${SAMPLE}_b${b}_k${k}.yak ${SAMPLE}.fa

yak inspect ${SAMPLE}_b${b}_k${k}.yak > ${SAMPLE}_b${b}_k${k}.hist

date
