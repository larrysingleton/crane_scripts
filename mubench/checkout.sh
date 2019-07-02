#!/bin/bash

LIST=repos

SEQ=$1

while read repo
do
	BASENAME=$(basename $repo | cut -d'.' -f1)
	DIR=${SEQ}_${BASENAME}

	git clone $repo $DIR
	
	if [ $? -eq 0 ]
	then
		((++SEQ))
	fi

done < $LIST
