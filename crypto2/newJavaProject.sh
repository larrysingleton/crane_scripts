#!/bin/bash

set -x

PROJECT_NAME=$(basename $1)
REPL_STR=XXX_PROJECT_NAME_XXX
PROJECT_FILES=~/bin/newJavaProject

rm -rf /tmp/$PROJECT_NAME
mkdir -vp /tmp/$PROJECT_NAME

cd /tmp/$PROJECT_NAME
sed "s/XXX_PROJECT_NAME_XXX/${PROJECT_NAME}/g" $PROJECT_FILES/.project > .project
cp -vf $PROJECT_FILES/.gitignore .
cp -vf $PROJECT_FILES/.classpath .
mkdir -vp bin
mkdir -vp src

######################################################
# copy source files into tmp
######################################################
SKS_USAGE=SecretKeySpecUsage.txt
BASE_GIT=/cygdrive/c/data/git-uno/CryptoProjects
cd $BASE_GIT
if [ -d $BASE_GIT/$PROJECT_NAME ]
then
        LIST=$(grep $PROJECT_NAME $BASE_GIT/$SKS_USAGE)
        for file in $LIST
        do
                DIR_NAME=$(dirname $file)
                cp -vf $file /tmp/$PROJECT_NAME/src
        done
fi

######################################################
# move files into package folders
######################################################
cd /tmp/$PROJECT_NAME/src
for file in `ls *.java`
do
	PKG=$(grep package $file | awk '{print $2}' | cut -d';' -f1 | tr '.' '/')
	echo $PKG
	mkdir -p $PKG
	mv -vf $file $PKG/
done
