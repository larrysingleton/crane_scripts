#!/bin/bash

GRPS=/cygdrive/c/data/git-uno/crane_scripts/group/groups
OUT=jcaDetectionCounts.md
> $OUT

echo "| id  | Name | Group | jca1 | jca2 | jca3 | jca4 | jca5 |" | tee -a $OUT
echo "| :-: | :-:  | :-:   | :-:  | :-:  | :-:  | :-:  | :-:  |" | tee -a $OUT

list=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
for project in $list
do
	# get the group name
        BPRJ=$(basename $project)
        ID=$(echo $BPRJ | cut -d'_' -f1)
        PRJ=$(echo $BPRJ | cut -d'_' -f2-)
        GRP=$(grep "^${PRJ}$(printf '\t')" $GRPS | awk '{print $2}')

	JCA=$(cat $project/jcaCount.csv | tr ',' '|')
	
	echo "|$ID|$PRJ|$GRP|$JCA|"  | tee -a $OUT

done
