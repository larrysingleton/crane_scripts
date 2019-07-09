#!/bin/bash

INPUT=$1

for folder in `find . -maxdepth 1 -type d | grep -v ^[.]$ | sort`
do
	BASE=$(basename $folder)
	SEQ=$(printf "%03d" $INPUT)	
	mv -v $folder ${SEQ}_${BASE}
	((++INPUT))
done
