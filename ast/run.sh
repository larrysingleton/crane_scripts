#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=1024
#SBATCH --workdir=/work/msong/larrys/dev/ast

LIST=/work/msong/larrys/dev/crypto/projects.crypto.unique.txt
OUT=/work/msong/larrys/dev/ast/results
> $OUT

REPOPATH=/work/hsiy/shared/firebugs/git-repo
AST=/work/msong/larrys/dev/ast/ASTSimpleVisitorCounter.jar
export JAVA_HOME=/work/hsiy/shared/programs/jdk1.8.0_191

date1=$(/bin/date +"%s")
echo "Start time: $date1"

cd $REPOPATH
for project in `cat $LIST`
do
	echo "AST - $project"
	$JAVA_HOME/bin/java -jar $AST -i $project >> $OUT
done

date2=$(/bin/date +"%s")
diff=$(($date2 - $date1))

echo "End time: $date2"
echo "Time to process: $diff seconds" 

