#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=1024
#SBATCH --workdir=/work/msong/larrys/dev/cloc


# # To run: sbatch cloc.sh folder

FOLDER=$1
if [ ! -d $FOLDER ]
then
        echo "$FOLDER not found"
        exit
fi
CLOC_PATH=/home/msong/larrys/dev/cloc

# Add your script below
eval $(perl -I$index.t/perl5/lib/perl5 -Mlocal::lib)
export PERL_MM_USE_DEFAULT=1

cd $FOLDER
list=$(find . -mindepth 1 -maxdepth 1 -type d | grep -v ^.$ | sort)

for repo in $list
do
	repoBase=$(/bin/basename $repo)
	nice -19 ~/bin/cloc --quiet $repo > $WORK/dev/cloc/results/$repoBase
done
