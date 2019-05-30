#!/bin/bash

set -x

PROJECT_NAME=SecretKeySpec2
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

set +x
while read file
do
	BaseProject=$(echo $file | cut -d '/' -f2 | tr '-' '_')
        PKG=$(grep ^package $file | awk '{print $2}' | cut -d';' -f1 | tr '.' '/')
	echo $PKG
	NEW_PATH=/tmp/$PROJECT_NAME/src/pkg_$BaseProject/$PKG
	mkdir -p $NEW_PATH
	cp -vf $file $NEW_PATH
done < $SKS_USAGE

