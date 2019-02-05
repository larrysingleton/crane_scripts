#!/bin/bash

REPO_PATH=/work/hsiy/shared/firebugs/git-repo
OUT=/work/msong/larrys/dev/crypto/gitrepourls
CRYPTO=/work/msong/larrys/dev/crypto/projects.crypto.unique.txt

> $OUT
while read name
do
	repoPath=$(find $REPO_PATH -maxdepth 1 -mindepth 1 -type d -iname \*_$name | head -1)
	configUrl=$(grep url $repoPath/.git/config | cut -d'=' -f2)
	base=$(basename $repoPath)

	echo -e "$base \t $configUrl" >> $OUT

done < $CRYPTO
