#!/bin/bash

echo

for url in `find . -maxdepth 2 -type f -name project.yml`
do
	cat $url | shyaml get-value repository.url 2>/dev/null
	echo
done
