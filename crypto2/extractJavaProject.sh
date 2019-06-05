#!/bin/bash
umask 022

PROJECT=$(basename $1)
COUNTER=0


if [ ! -d $PROJECT ]
then
	echo "$PROJECT not a directory"
	exit
fi

CLASSPATH_FILE=/tmp/$PROJECT/.classpath
PROJECT_FILE=/tmp/$PROJECT/.project
ORIGIN=/tmp/${PROJECT}/origination.txt

mkNewClasspathFile() {
	echo -e '<?xml version="1.0" encoding="UTF-8"?>' > $CLASSPATH_FILE
	echo -e '<classpath>' >> $CLASSPATH_FILE
	echo -e '\t<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.8"/>' >> $CLASSPATH_FILE
	echo -e '\t<classpathentry kind="output" path="bin"/>' >> $CLASSPATH_FILE
	echo -e "</classpath>" >> $CLASSPATH_FILE
}

addSrcClassPath() {
	SRC=$1
	newline=$(echo -e "\t<classpathentry kind=\"src\" path=\"${SRC}\"/>")

	# add entry before closing tag
	sed -i "`wc -l < $CLASSPATH_FILE`i\\${newline}\\" $CLASSPATH_FILE
}

mkNewDotProjectFile() {
	echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $PROJECT_FILE
	echo -e "<projectDescription>" >> $PROJECT_FILE
	echo -e "\t<name>$PROJECT</name>" >> $PROJECT_FILE
	echo -e "\t<comment></comment>" >> $PROJECT_FILE
	echo -e "\t<projects/>" >> $PROJECT_FILE
	echo -e "\t<buildSpec>" >> $PROJECT_FILE
	echo -e "\t\t<buildCommand>" >> $PROJECT_FILE
	echo -e "\t\t\t<name>org.eclipse.jdt.core.javabuilder</name>" >> $PROJECT_FILE
	echo -e "\t\t\t<arguments></arguments>" >> $PROJECT_FILE
	echo -e "\t\t</buildCommand>" >> $PROJECT_FILE
	echo -e "\t</buildSpec>" >> $PROJECT_FILE
	echo -e "\t<natures>" >> $PROJECT_FILE
	echo -e "\t\t<nature>org.eclipse.jdt.core.javanature</nature>" >> $PROJECT_FILE
	echo -e "\t</natures>" >> $PROJECT_FILE
	echo -e "</projectDescription>" >> $PROJECT_FILE
}

mkNewJavaProject() {
	rm -rf /tmp/$PROJECT
	mkdir -vp /tmp/$PROJECT/bin

	> $CLASSPATH_FILE
	> $PROJECT_FILE

	# add .gitgnore file
	echo "/bin/" > /tmp/$PROJECT/.gitignore

	# add .project file
	mkNewDotProjectFile

	# add git url to origination file
	GITURL=$(grep url ${PROJECT}/.git/config | cut -d'=' -f2)
	echo -e "git: $GITURL\n" > $ORIGIN

	echo
}


addSources() {
	for folder in $JAVA_FOLDERS
	do
		# count the number of java files in this folder
		javaCount=$(find $folder -type f -name \*.java | wc -l)
		if [ $javaCount -eq 0 ]
		then
			echo "Skipping $folder ($javaCount files)"
			continue;
		fi

		((++COUNTER))

		SOURCE="src${COUNTER}"

		# track some stats for later review
		ORIGIN_OUTPUT="$SOURCE : $folder"
		echo $ORIGIN_OUTPUT | tee -a $ORIGIN
		#echo -e "$SOURCE : $folder" >> $ORIGIN

		# copy the contents of this java folder
		mkdir -p /tmp/$PROJECT/$SOURCE
		cp -rp $folder/* /tmp/${PROJECT}/${SOURCE}
		addSrcClassPath $SOURCE	

	done
	echo
}

displayJavaFolders() {
	for folder in $JAVA_FOLDERS
	do
		javaCount=$(find $folder -type f -name \*.java | wc -l)
		printf "(%03d) $folder\n" $javaCount
	done
	echo
}

echo "Finding folders that contain java files..."
JAVA_FOLDERS=$(find $PROJECT -type d -iname java -not -ipath "*/*test*/*")
cnt=$(echo $JAVA_FOLDERS | wc -w)
if [ $cnt -gt 0 ]
then
	echo "Java paths found: $cnt"
	displayJavaFolders

	echo -e "Creating project: ${PROJECT}"
	mkNewJavaProject
	mkNewClasspathFile
	addSources
fi


echo "Finding folders that contain java files, but not in a java folder..."
JAVA_FOLDERS=$(find $PROJECT -type f -iname \*.java -not -ipath "*/*java*/*" -not -ipath "*/*test*/*" -exec dirname {} \; | sort -u)
cnt=$(echo $JAVA_FOLDERS | wc -w)
echo "Java paths found: $cnt"
if [ $cnt -eq 0 ]
then
	exit
fi

displayJavaFolders

while true
do
	# prompt user to add source from path
	read -p "Enter path: " -r
	echo
	JAVA_FOLDERS=$REPLY
	addSources

	read -p "Continue? " -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		continue
	else
		break	
	fi
done

