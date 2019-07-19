#!/bin/bash

> jcaCounts

list=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
for project in $list
do
	JAVA=$(find $project -type f -name \*.java)
	jca=$(grep javax.crypto $JAVA | wc -l)
	sks=$(grep "new SecretKeySpec" $JAVA | wc -l)
	echo "$(basename $project) $jca $sks"  | tee -a jcaCounts
done
