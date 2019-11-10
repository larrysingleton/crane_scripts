#!/bin/bash

GRPS=/cygdrive/c/data/git-uno/crane_scripts/group/groups

OUT=jcaCounts.md
> $OUT

echo "| id  | Name | Group | Classes | Imports | jca1 | jca2 | jca3 | jca4 | jca5 |" | tee -a $OUT
echo "| :-: | :-:  | :-:   | :-:     | :-:     | :-:  | :-:  | :-:  | :-:  | :-:  |" | tee -a $OUT

list=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
for project in $list
do

	# get the group name
	BPRJ=$(basename $project)
	ID=$(echo $BPRJ | cut -d'_' -f1)
	PRJ=$(echo $BPRJ | cut -d'_' -f2-)
	GRP=$(grep "^${PRJ}$(printf '\t')" $GRPS | awk '{print $2}')
	echo $GRP > ${project}/group

	# list of java files
	JAVA=$(find $project -type f -name \*.java)

	# number of classes using JCA
	classes=$(grep -c "import javax.crypto" $JAVA | grep -v :0$ | wc -l)

	# number of instances of JCA used
	imports=$(grep "import javax.crypto" $JAVA | wc -l)

	# JCA1 : MessageDigest.getInstance
	jca1list=${project}/jca1.list
	grep "Cipher.getInstance" $JAVA > $jca1list
	jca1=$(cat $jca1list | wc -l)

	# JCA2 : Cipher.getInstance
	jca2list=${project}/jca2.list
	grep "MessageDigest.getInstance" $JAVA > $jca2list
	jca2=$(cat $jca2list | wc -l)

	# JCA3: SecretKeySpec
	jca3list=${project}/jca3.list
	grep "new SecretKeySpec" $JAVA > $jca3list
	jca3=$(cat $jca3list | wc -l)

	# JCA4: PBEParameterSpec
	jca4list=${project}/jca4.list
	grep "new PBEParameterSpec" $JAVA > $jca4list
	jca4=$(cat $jca4list | wc -l)

	# JCA5: SecureRandom.getInstance
	jca5list=${project}/jca5.list
	> $jca5list

	cnts=$(grep -c "SecureRandom.getInstance" $JAVA | grep -v :0)
	if [ "$cnt" != "" ]
	then
		for file in `echo $cnts | cut -d':' -f1`
		do
			echo $file >> $jca5list
			grep "SecureRandom.getInstance" $file >> $jca5list
			grep "setSeed" $file >> $jca5list
		done	
	fi
	jca5=$(cat $jca5list | grep -v $project | wc -l)
	
	echo "| $ID | $PRJ | $GRP | $classes | $imports | $jca1 | $jca2 | $jca3 | $jca4 | $jca5 |"  | tee -a $OUT
done
