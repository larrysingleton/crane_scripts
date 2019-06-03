#!/bin/bash

COUNTER=0
PROJECT=$(basename $1)
umask 022

if [ ! -d $PROJECT ]
then
	echo "$PROJECT not a directory"
	exit
fi


createProjects() {
	for folder in $JAVA_FOLDERS
	do
		# count the number of java files in this folder
		javaCount=$(find $folder -type f -name \*.java | wc -l)
		if [ $javaCount -le 1 ]
		then
			echo "Skipping $folder ($javaCount files)"
			continue;
		fi

		# prompt user to create project
		read -p "Create project for: $folder [javaFiles: $javaCount]?" -n 1 -r
		echo

		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			((++COUNTER))
			newProject="${PROJECT}_${COUNTER}"
			echo -e "\t creating project: ${newProject}"


			# create a new project
			~/bin/newJavaProject/mkJavaProject.sh ${newProject}

			# copy the contents of this java folder
			cp -rp $folder/* /tmp/${newProject}/src

			# track some stats for later review
			ORIGIN=/tmp/${newProject}/origination.txt
			echo -e "Origination folder: $folder" > $ORIGIN

			URL=$(grep url ${PROJECT}/.git/config | cut -d'=' -f2)
			echo -e "\r\ngit: $URL" >> $ORIGIN
			echo >> $ORIGIN

		fi
	done
	echo "Done."
	echo
}

echo "Finding folders that contain java files..."
JAVA_FOLDERS=$(find $PROJECT -type d -iname java -not -ipath "*/*test*/*")
cnt=$(echo $JAVA_FOLDERS | wc -w)
echo "Java paths found: $cnt"
echo $JAVA_FOLDERS
echo
createProjects


echo "Finding folders that contain java files, but not in a java folder..."
JAVA_FOLDERS=$(find $PROJECT -type f -iname \*.java -not -ipath "*/*java*/*" -not -ipath "*/*test*/*" -exec dirname {} \; | sort -u)
cnt=$(echo $JAVA_FOLDERS | wc -w)
echo "Java paths found: $cnt"
if [ $cnt -eq 0 ]
then
	exit
fi

for folder in $JAVA_FOLDERS
do
	javaCount=$(find $folder -type f -name \*.java | wc -l)
	printf "(%03d) $folder\n" $javaCount
done
echo

while true
do
	# prompt user to create project
	read -p "Enter path: " -r
	echo
	JAVA_FOLDERS=$REPLY
	createProjects
done

