#!/bin/bash
# Purpose: Read Comma Separated CSV File
# Author: Vivek Gite under GPL v2.0+
# ------------------------------------------

INPUT=/c/Users/mnova/source/repos/ProjectDat01/Trial01.csv
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

TAG_SYS_01=('01', 
			'02', 
			'03')
OLDIFS=$IFS
IFS=','



while read col1 col2 col3
do
	echo "Name : $col1"
	echo "DOB : $col2"

	for zone in "${TAG_SYS_01[@]}"
	do
		echo "$zone, please wait ..."
		echo $col2
	done
done < $INPUT
IFS=$OLDIFS


