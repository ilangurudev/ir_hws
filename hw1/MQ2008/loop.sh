max=5
for i in `seq 1 $max`
do
    sh svm.sh $1 $i | tail -6 | head -n 1 >> results/results_$1.txt
done
