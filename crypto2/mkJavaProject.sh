#!/bin/bash

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
