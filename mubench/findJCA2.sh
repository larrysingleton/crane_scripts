#!/bin/bash

GRPS=/cygdrive/c/data/git-uno/crane_scripts/group/groups

OUT=jcaCounts.md
> $OUT

echo "| Name | Group | JCAc | JCAi | SKSi |" | tee -a $OUT
echo "| ---- | :-:   | :-:  | :-:  | :-:  |" | tee -a $OUT

list=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
for project in $list
do

	# get the group name
	BPRJ=$(basename $project)
	PRJ=$(echo $BPRJ | cut -d'_' -f2-)
	GRP=$(grep "^${PRJ}$(printf '\t')" $GRPS | awk '{print $2}')

	# list of java files
	JAVA=$(find $project -type f -name \*.java)

	# number of classes using JCA
	jca1=$(grep -c javax.crypto $JAVA | grep -v :0$ | wc -l)

	# number of instances of JCA
	jca2=$(grep javax.crypto $JAVA | wc -l)

	# number of instances overall of SKS
	sks=$(grep "new SecretKeySpec" $JAVA | wc -l)
	echo "| $BPRJ | $GRP | $jca1 | $jca2 | $sks |"  | tee -a $OUT
done
