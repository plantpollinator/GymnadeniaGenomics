#!/bin/bash
#SBATCH --job-name="Reas_yak_count"
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=jic-short
#SBATCH --mem 4G
#SBATCH --time=0-02:00
#SBATCH -o /jic/scratch/groups/Matthew-Hartley/kourounr/Gymnadenia_populations/output_error/%x_%A_%a_%N.out
#SBATCH -e /jic/scratch/groups/Matthew-Hartley/kourounr/Gymnadenia_populations/output_error/%x_%A_%a_%N.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rea.antoniou-kourounioti@jic.ac.uk
#SBATCH --array=1-3

SAMPLES=(GcKG13 RTK3E2 RTK3F2 RTK4G)
SAMPLE_p=${SAMPLES[1]}
SAMPLE_m=${SAMPLES[2]}

echo "paternal: ${SAMPLE_p}, maternal: ${SAMPLE_m}"


REFs=(GcKG13_RTK3E2 GcKG13_RTK3F2 RTK3E2_RTK3F2)
REF=${REFs[$SLURM_ARRAY_TASK_ID-1]}
REF_DIR=${REF}_F1.fa
mkdir -p $REF

#parameters
k=17
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

yak triobin ${SAMPLE_p}_b${b}_k${k}.yak ${SAMPLE_m}_b${b}_k${k}.yak ${REF_DIR}>${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt

patStr=$(awk '$3>=21&&$4<=2&&$2=="p"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
patStr2=$(printf "Strict paternal: %'d\n" ${patStr})
echo "${patStr2}" >${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

matStr=$(awk '$4>=21&&$3<=2&&$2=="m"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
matStr2=$(printf "Strict maternal: %'d\n" ${matStr})
echo "${matStr2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

echo "% paternal: $((100*patStr/(matStr+patStr)))%">>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt
echo "% maternal: $((100*matStr/(matStr+patStr)))%">>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

pat=$(awk '$2=="p"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
pat2=$(printf "paternal: %'d\n" ${pat})
echo "${pat2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

mat=$(awk '$2=="m"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
mat2=$(printf "maternal: %'d\n" ${mat})
echo "${mat2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

amb=$(awk '$2=="a"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
amb2=$(printf "ambiguous: %'d\n" ${amb})
echo "${amb2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

zer=$(awk '$2=="0"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
zer2=$(printf "0: %'d\n" ${zer})
echo "${zer2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt


date
