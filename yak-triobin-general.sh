yak triobin ${SAMPLE_p}_b${b}_k${k}.yak ${SAMPLE_m}_b${b}_k${k}.yak ${REF_DIR}>${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt

pat=$(awk '$2=="p"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
pat2=$(printf "paternal: %'d\n" ${pat})
echo "${pat2}" >${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

mat=$(awk '$2=="m"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
mat2=$(printf "maternal: %'d\n" ${mat})
echo "${mat2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

amb=$(awk '$2=="a"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
amb2=$(printf "ambiguous: %'d\n" ${amb})
echo "${amb2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt

zer=$(awk '$2=="0"' ${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin.txt |wc -l)
zer2=$(printf "0: %'d\n" ${zer})
echo "${zer2}" >>${REF}/${SAMPLE_p}_${SAMPLE_m}_${REF}_b${b}_k${k}_triobin_linecounts.txt
