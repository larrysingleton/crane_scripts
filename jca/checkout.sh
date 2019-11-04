#!/bin/bash

LIST=repos

while read repo
do
	BASENAME=$(basename $repo | cut -d'.' -f1)
	git clone $repo data/$BASENAME
done < $LIST
