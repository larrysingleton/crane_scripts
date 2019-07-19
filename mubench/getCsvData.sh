#!/bin/bash

for project in `find . -maxdepth 1 -type d`
do
	PRJ=$(basename $project)
	NUM=$(echo $PRJ | cut -d'_' -f1)
	SRC=$(grep "Total paths" $PRJ/origination.txt | cut -d':' -f2)
	JAVA=$(grep "Total Java files" $PRJ/origination.txt | cut -d ':' -f2)
	GIT=$(grep "^git" $PRJ/origination.txt | cut -d':' -f2-)

	echo -e "$NUM, $PRJ, $GIT, $SRC, $JAVA"
done
