project urls obtain from MUBench data folder
https://github.com/stg-tud/MUBench


1. extractRepoUrl.sh - will obtain a list of "repos" from the project.yml files
2. checkout.sh - reads the file "repos" and clones each project
3. findJCA.sh - searches each project for javax.crypto - storing results in jcaCounts
4. delete all projects with a zero JCA count
5. reseq.sh - to resequence and rename the projects in preperation for extraction conversion


