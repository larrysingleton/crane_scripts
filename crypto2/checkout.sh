#!/bin/bash
LIST=cryptoProjects.list

while read line
do
	SEQ=$(echo $line | awk '{print $1}')
	REPO=$(echo $line | awk '{print $2}')
	USER=$(echo $REPO | cut -d'/' -f4)
	BASENAME=$(basename $REPO | cut -d'.' -f1)


	DIR=${SEQ}_${USER}_${BASENAME}
	if [ ! -d $DIR ]
	then
		echo "Cloning $REPO to $DIR"
		git clone $REPO $DIR
	else
		echo "Skipping $DIR"
	fi

done < $LIST
