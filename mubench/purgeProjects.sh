#!/bin/bash

while read line
do
	echo "$line"
	cnt=$(echo $line | awk '{print $1}')
	prj=$(echo $line | awk '{print $2}')

	if [ $cnt -eq 0 ]
	then
		echo -e "\tPurging project: $prj ($cnt)"
		rm -rf $prj
	fi

done < jcaCounts
