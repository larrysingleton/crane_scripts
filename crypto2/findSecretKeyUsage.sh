#!/bin/bash

INPUT=SecretKeySpecUsage.txt
OUTPUT=SecretKeySpecUsageAll.txt

> $OUTPUT

for file in $(cat $INPUT)
do
	echo $file >> $OUTPUT
	grep "new SecretKeySpec" $file >> $OUTPUT 
done
