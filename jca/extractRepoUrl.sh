#!/bin/bash

OUTPUT=repos
> $OUTPUT

echo

for url in `find . -maxdepth 2 -type f -name project.yml`
do
	GIT=$(cat $url | shyaml get-value repository.url)
	echo -e "$GIT" | tee -a $OUTPUT 2>/dev/null
done
