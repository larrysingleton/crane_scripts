#!/bin/bash

shopt -s nocasematch
shopt -s nocaseglob

CRYPTO=/work/msong/larrys/dev/crypto/projects.crypto.unique.txt
REPO=/work/hsiy/shared/firebugs/git-repo
myReadme=/work/msong/larrys/dev/group/readme

> cpfails
while read name
do
	repoPath=$(find $REPO -maxdepth 1 -mindepth 1 -type d -iname \*_${name} |  head -1) 
	base=$(basename $repoPath)
	cp -v $repoPath/README.md $myReadme/${base}_readme.md 2>> cpfails

done < $CRYPTO
