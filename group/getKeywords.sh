#!/bin/bash

FILE=$1
API_TOKEN=7e9edab0-2434-11e9-bb65-69ed2d3c7927
URL=http://api.cortical.io:80/rest/text/keywords?retina_name=en_associative
#URL=http://api.cortical.io:80/rest/text/keywords?retina_name=en_synonymous
KEYWORDS=/work/msong/larrys/dev/group/keywords
REPORT=/work/msong/larrys/dev/group/report

if [ ! -f $FILE ] || [ ! -s $FILE ]
then
	echo "$FILE not found"
	exit
fi


curl 	-k \
	-X POST \
	-H "api-key: $API_TOKEN" \
	-H "Content-Type: application/json" \
	-d @"${FILE}" \
	--output $KEYWORDS/$FILE.keywords \
	-s "$URL"

keys=$(cat $KEYWORDS/$FILE.keywords)

echo "$FILE $keys"
