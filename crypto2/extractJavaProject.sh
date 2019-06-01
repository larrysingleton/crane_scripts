#!/bin/bash

PROJECT=$(basename $1)

if [ ! -d $PROJECT ]
then
	echo "$PROJECT not a directory"
	exit
fi

JAVA_FOLDERS=$(find $PROJECT -type d -name java)

i=0
for folder in $JAVA_FOLDERS
do
	# count the number of java files in this folder
	javaCount=$(find $folder -type f -name \*.java | wc -l)
	if [ $javaCount -le 1 ]
	then
		continue;
	fi

	# prompt user to create project
	read -p "Create project for: $folder [javaFiles: $javaCount]?" -n 1 -r
	echo

	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		((++i))
		newProject="${PROJECT}_${i}"
		echo -e "\t creating project: ${newProject}"

		# create a new project
		~/bin/newJavaProject/mkJavaProject.sh ${newProject}

		# copy the contents of this java folder
		cp -vrp $folder/* /tmp/${newProject}/src
	fi
done

echo "Done."

