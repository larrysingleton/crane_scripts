#!/bin/bash

INPUT=$1

if [ "$INPUT" == "" ]
then
	echo "Missing input"
	echo "$0 [seq]"
	exit
fi

for folder in `find . -mindepth 1 -maxdepth 1 -type d | sort`
do
	BASE=$(basename $folder)
	SEQ=$(printf "%03d" $INPUT)	
	mv -v $folder ${SEQ}_${BASE}
	((++INPUT))
done
