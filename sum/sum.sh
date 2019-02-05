#!/bin/bash

OUT=/work/msong/larrys/dev/sum/report.csv
CRYPTO=/work/msong/larrys/dev/crypto/projects.crypto.unique.txt
CLOC=/work/msong/larrys/dev/cloc/results
AST=/work/msong/larrys/dev/ast/results
GROUP=/work/msong/larrys/dev/group/2019-01-30_crypto_classifications.csv
WORK=/work/hsiy/shared/firebugs/git-repo

echo "id, repo, group, code, class, method, field, commits" > $OUT

for line in `cat $CRYPTO`
do 
	echo $line

	id=$(echo $line | cut -d'_' -f1); 
	repo=$(echo $line | cut -d'_' -f2-); 
	grp=$(grep -i $repo $GROUP | cut -d',' -f3)

	sum=$(grep Java $CLOC/$line | grep -v JavaScript | awk '{print $5}')
	ast=$(grep $line $AST | cut -d',' -f2-);

	cd $WORK/$line
	commits=$(/usr/bin/git rev-list --all | wc -l)

	echo "$id,$repo,$grp,$sum,$ast,$commits" >> $OUT
done

