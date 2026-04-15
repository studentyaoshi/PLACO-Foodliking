#!/bin/bash

echo "##############################################"
echo "#                                            #"
echo "#                   PLACO                    #"
echo "#                                            #"
echo "#     2023.08.15           Shi Yao & Hao Wu  #"
echo "#                                            #"
echo "##############################################"
echo ""

pw_PLACO='PLACO_pipeline'
pwd=`pwd`

if [ ${#} == "3" ]; then
	echo ""
	echo "----------------------------------------------"
	echo "- File 1: ${1}"
	echo "- File 2: ${2}"
	echo "- result: ${pwd}/${3}.PLACO"
	echo "----------------------------------------------"
	echo ""
	echo "[Start]"
	date
	echo "Now select the Z and P matrix..."
	echo ""

#	work
	python ${pw_PLACO}/0.work_PLACO.py ${1} ${2} ${3}.list.anno
	cat ${3}.list.anno | awk '$4*$4<80 && $6*$6<80' > ${3}.list.anno.filter_z
	cat ${3}.list.anno.filter_z | cut -f4,6 > ${3}.list.matrix_z
	cat ${3}.list.anno.filter_z | cut -f5,7 > ${3}.list.matrix_p

#	echo
	echo "Calculate PLACO..."
	echo ""

#	PLACO
	Rscript ${pw_PLACO}/0.work_PLACO.r ${3}.list.matrix_z ${3}.list.matrix_p ${3}.list.matrix_z.decor ${3}.list.PLACO

#	echo
	echo "Merge files..."

#	merge.PLACO
	paste ${3}.list.anno.filter_z ${3}.list.PLACO > ${3}.PLACO

#	rm
	rm ${3}.list.anno ${3}.list.anno.filter_z ${3}.list.matrix_z ${3}.list.matrix_p ${3}.list.matrix_z.decor ${3}.list.PLACO

	echo ""
	echo "[Finished]"
	date
	echo ""
else
	echo ""
	echo "----------------------------------------------"
	echo ">>> PLACO [GWAS_1.ma] [GWAS_2.ma] [result]"
	echo ""
	echo "- Parameter1 and Parameter2: Both absolute and"
	echo "  relative paths are recognizable."
	echo "- GWAS.ma(SNP A1 A2 EAF BETA SE P N)"
	echo ""
	echo "- Parameter3: Only file names can be entered."
	echo "----------------------------------------------"
	echo ""
fi
