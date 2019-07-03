#!/bin/bash

SEQ=$1

for folder in `find . -maxdepth 1 -type d | grep -v ^[.]$`
do
	BASE=$(basename $folder)
	mv -v $folder ${SEQ}_${BASE}
	((++SEQ))
done
