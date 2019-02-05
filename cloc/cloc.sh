#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=1024
#SBATCH --workdir=/work/msong/larrys/dev/cloc

# Add your script below
eval $(perl -I$index.t/perl5/lib/perl5 -Mlocal::lib)
export PERL_MM_USE_DEFAULT=1

for repo in `find /work/hsiy/shared/firebugs/git-repo -mindepth 1 -maxdepth 1 -type d 2>/dev/null` 
do
	repoBase=$(/bin/basename $repo)
	nice -19 /home/msong/larrys/dev/cloc/cloc --quiet $repo > $WORK/dev/cloc/results/$repoBase
done
