sudo ./svm_rank_learn -c $1 -p 2 ./Fold$2/train.txt ./Fold$2/model$2
sudo ./svm_rank_classify ./Fold$2/test.txt ./Fold$2/model$2 ./Fold$2/predictions