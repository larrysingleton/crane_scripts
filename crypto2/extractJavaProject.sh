#!/bin/bash
# Larry Singleton
# LarrySingleton@unomaha.edu
# Version 2.1
# Date: 06/08/2019

umask 022

#which bash
#bash --version
echo

PROJECT=$(basename $1)
COUNTER=0
JAVA_COUNTER=0
MKNEWPROJECT=0

if [ ! -d $PROJECT ]
then
	echo "$PROJECT is not a directory"
	exit
fi

CLASSPATH_FILE=/tmp/$PROJECT/.classpath
PROJECT_FILE=/tmp/$PROJECT/.project
ORIGIN=/tmp/${PROJECT}/origination.txt

PRINT() {
	echo -e "$1"
}

mkNewClasspathFile() {
	PRINT '<?xml version="1.0" encoding="UTF-8"?>' > $CLASSPATH_FILE
	PRINT '<classpath>' >> $CLASSPATH_FILE
	PRINT '\t<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.8"/>' >> $CLASSPATH_FILE
	PRINT '\t<classpathentry kind="output" path="bin"/>' >> $CLASSPATH_FILE
	PRINT "</classpath>" >> $CLASSPATH_FILE
}

addSrcClassPath() {
	SRC=$1
	newline=$(echo -e "\t<classpathentry kind=\"src\" path=\"${SRC}\"/>")

	# add entry before closing tag
	sed -i "`wc -l < $CLASSPATH_FILE`i\\${newline}\\" $CLASSPATH_FILE
}

mkNewDotProjectFile() {
	PRINT "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $PROJECT_FILE
	PRINT "<projectDescription>" >> $PROJECT_FILE
	PRINT "\t<name>$PROJECT</name>" >> $PROJECT_FILE
	PRINT "\t<comment></comment>" >> $PROJECT_FILE
	PRINT "\t<projects/>" >> $PROJECT_FILE
	PRINT "\t<buildSpec>" >> $PROJECT_FILE
	PRINT "\t\t<buildCommand>" >> $PROJECT_FILE
	PRINT "\t\t\t<name>org.eclipse.jdt.core.javabuilder</name>" >> $PROJECT_FILE
	PRINT "\t\t\t<arguments></arguments>" >> $PROJECT_FILE
	PRINT "\t\t</buildCommand>" >> $PROJECT_FILE
	PRINT "\t</buildSpec>" >> $PROJECT_FILE
	PRINT "\t<natures>" >> $PROJECT_FILE
	PRINT "\t\t<nature>org.eclipse.jdt.core.javanature</nature>" >> $PROJECT_FILE
	PRINT "\t</natures>" >> $PROJECT_FILE
	PRINT "</projectDescription>" >> $PROJECT_FILE
}

cpReadmeFile() {
	# determnine if a readme.md file exists
	README=$(find $PROJECT -maxdepth 1 -type f -iname readme*)
	if [ -f "$README" ]
	then
		cp $README /tmp/$PROJECT/README.md	
	fi
}

mkNewJavaProject() {
	rm -rf /tmp/$PROJECT
	mkdir -p /tmp/$PROJECT/bin

	> $CLASSPATH_FILE
	> $PROJECT_FILE

	# add .gitgnore file
	PRINT "/bin/" > /tmp/$PROJECT/.gitignore

	# add .project file
	mkNewDotProjectFile

	# add readme.md if it exists
	cpReadmeFile

	# add git url to origination file
	GITURL=$(grep url ${PROJECT}/.git/config | cut -d'=' -f2)
	PRINT "git: $GITURL\n" > $ORIGIN

	echo
}

createProject() {
	echo -e "Creating project: ${PROJECT}"
	mkNewJavaProject
	mkNewClasspathFile
	MKNEWPROJECT=1
}

addSources() {

	if [ $MKNEWPROJECT -eq 0 ]
	then
		createProject
	fi

	for folder in $JAVA_FOLDERS
	do
		# count the number of java files in this folder
		javaCount=$(find $folder -type f -name \*.java | wc -l)
		if [ $javaCount -eq 0 ]
		then
			PRINT "($javaCount) SKIP : $folder"
			continue;
		fi

		((++COUNTER))
		let "JAVA_COUNTER += $javaCount"

		SOURCE="src${COUNTER}"


		# track some stats for later review
		shortFolder=$(echo $folder | cut -d '/' -f2-)
		ORIGIN_OUTPUT="($javaCount) $SOURCE : $shortFolder"
		PRINT "$ORIGIN_OUTPUT" | tee -a $ORIGIN

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
		echo $folder >> /tmp/x
	done
	echo
}

reportFinalResults() {
#	PRINT "\n" | tee -a $ORIGIN
	PRINT "Total paths: $COUNTER" | tee -a $ORIGIN
	PRINT "Total Java files: $JAVA_COUNTER" | tee -a $ORIGIN
	PRINT "Location: /tmp/${PROJECT}"
	PRINT "Done."
	echo; echo;
}

#########################
# Start of script
#########################
PRINT "Project: $PROJECT"

PRINT "Finding java folders..."
JAVA_FOLDERS=$(find $PROJECT -type d -iname java -not -ipath "*/*test*/*")
cnt=$(echo $JAVA_FOLDERS | wc -w)
if [ $cnt -gt 0 ]
then
	PRINT "Java paths found: $cnt"
	addSources
fi

PRINT "Finding source/src folders..."
FOLDERS=$(find $PROJECT -type f -iname \*.java -not -ipath "*/*java*/*" -not -ipath "*/*test*/*" -exec dirname {} \; | sort -u)
cnt=$(echo $FOLDERS | wc -w)
if [ $cnt -gt 0 ]
then
	rm -f /tmp/$$ 2> /dev/null
	PRINT "Java paths found: $cnt"

	NEW_FOLDERS=""
	for path in $FOLDERS
	do
		if [[ $path =~ "src" || $path =~ "source" ]]
		then
			echo $path |  sed 's/src\/.*/src/' | sed 's/source\/.*/source/' >> /tmp/$$
		fi
	done

	# sort list unique 
	JAVA_FOLDERS=$(cat /tmp/$$ | sort -u) 
	cnt=$(echo $JAVA_FOLDERS | wc -w)
	echo "Reduced paths to: $cnt"
	rm -f /tmp/$$ 2> /dev/null

	addSources
fi

PRINT "Finding other source folders..."
JAVA_FOLDERS=$(find $PROJECT -type f -iname \*.java -not -ipath "*/*java*/*" -not -ipath "*/*test*/*" -not -ipath "*/*source*/*" -not -ipath "*/*src*/*" -exec dirname {} \; | sort -u)
cnt=$(echo $JAVA_FOLDERS | wc -w)
if [ $cnt -gt 0 ]
then
	PRINT "Java paths found: $cnt"
	addSources
fi

reportFinalResults
exit
###################################################################################

if [ $cnt -eq 0 ]
then
	reportFinalResults
	exit
fi

displayJavaFolders

while true
do
	read -p "Continue? " -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo
		# prompt user to add source from path
		read -p "Enter path: " -r
		echo
		JAVA_FOLDERS=$REPLY
		addSources
	else
		break	
	fi
done

reportFinalResults
