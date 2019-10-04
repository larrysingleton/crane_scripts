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

	# list of java files
	JAVA=$(find $project -type f -name \*.java)

	# number of classes using JCA
	classes=$(grep -c "import javax.crypto" $JAVA | grep -v :0$ | wc -l)

	# number of instances of JCA used
	imports=$(grep "import javax.crypto" $JAVA | wc -l)

	# JCA1 : MessageDigest.getInstance
	jca1=$(grep "MessageDigest.getInstance" $JAVA | wc -l)

	# JCA2 : Cipher.getInstance
	jca2=$(grep "Cipher.getInstance" $JAVA | wc -l)

	# JCA3: SecretKeySpec
	jca3=$(grep "new SecretKeySpec" $JAVA | wc -l)

	# JCA4: PBEParameterSpec
	jca4=$(grep "new PBEParameterSpec" $JAVA | wc -l)

	# JCA5: SecureRandom.getInstance
	jca5=$(grep "SecureRandom.getInstance" $JAVA | wc -l)
	
	echo "| $ID | $PRJ | $GRP | $classes | $imports | $jca1 | $jca2 | $jca3 | $jca4 | $jca5 |"  | tee -a $OUT
done
