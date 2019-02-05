#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=1024
#SBATCH --workdir=/work/msong/larrys/dev/crypto

REPO_PATH=/work/hsiy/shared/firebugs/git-repo
OUT=/work/msong/larrys/dev/crypto/crypto_results

find $REPO_PATH -type f -name \*.java -exec grep "javax.crypto" {} \; -print > $OUT

