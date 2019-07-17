#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=1024
#SBATCH --workdir=/work/msong/larrys/dev/ast

# To run: sbatch run.sh folder
FOLDER=$1
if [ ! -d $FOLDER ]
then
	echo "$FOLDER not found"
	exit
fi

cd $FOLDER

AST_PATH=/work/msong/larrys/dev/ast
export JAVA_HOME=/work/hsiy/shared/programs/jdk1.8.0_191
JAR=$AST_PATH/ASTSimpleVisitorCounter.jar

OUT=$AST_PATH/results
> $OUT

date1=$(/bin/date +"%s")
echo "Start time: $date1"

list=$(find . -maxdepth 1 -type d | grep -v ^.$ | sort)
for project in $list
do
	BASE=$(basename $project)
	$JAVA_HOME/bin/java -jar $JAR -i $BASE | tee -a $OUT
done

date2=$(/bin/date +"%s")
diff=$(($date2 - $date1))

echo "End time: $date2"
echo "Time to process: $diff seconds"

dt=$(/bin/date +"%Y-%m-%d")
RESULTS=$AST_PATH/${dt}-results
cp $OUT $RESULTS
