#!/bin/bash

> jcaCounts

for project in `find . -maxdepth 1 -type d | grep -v ^[.]$`
do
	echo -e "\nSearching: $project ..."
	cnt=$(find $project -type f -name \*.java -exec grep javax.crypto {} \; -print | wc -l)
	echo -e "\t$cnt"

	echo "$cnt $project" >> jcaCounts
done
