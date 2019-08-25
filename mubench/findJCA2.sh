#!/bin/bash

OUT=jcaCounts.md
> $OUT

echo "| Name | JCAc | JCAi | SKSi |" | tee -a $OUT
echo "| ---- | :-: | :-:  | :-: |" | tee -a $OUT

list=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
for project in $list
do
	JAVA=$(find $project -type f -name \*.java)

	# number of classes using JCA
	jca1=$(grep -c javax.crypto $JAVA | grep -v :0$ | wc -l)

	# number of instances of JCA
	jca2=$(grep javax.crypto $JAVA | wc -l)

	# number of instances overall of SKS
	sks=$(grep "new SecretKeySpec" $JAVA | wc -l)
	echo "| $(basename $project) | $jca1 | $jca2 | $sks |"  | tee -a $OUT
done
