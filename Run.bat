::cat Data/Tweets.train | perl TermExtraction.pl > Data/Terms.feats.5m
::cat Data/Tweets.train | perl Tweets2Feats.pl Data/Terms.feats.5m > Feats/Feats.train.5m
::cat Data/Tweets.test  | perl Tweets2Feats.pl Data/Terms.feats.5m > Feats/Feats.test.5m
::svm_multiclass_learn -c 100000 Feats/Feats.train.5m models/model.5m
svm_multiclass_classify Feats/Feats.test.5m models/model.5m Prediction/pred.5m
perl Evaluation.pl Feats/Feats.test.5m Prediction/pred.5m > Results/stats.5m

::cat Data/Tweets.train | perl SelectRandom.pl 5000000 500000 > Data/Tweets.train.500k
::cat Data/Tweets.train.500k | perl TermExtraction.pl > Data/Terms.feats.500k
::cat Data/Tweets.train.500k  | perl Tweets2Feats.pl Data/Terms.feats.500k > Feats/Feats.train.500k
::cat Data/Tweets.test  | perl Tweets2Feats.pl Data/Terms.feats.500k > Feats/Feats.test.500k
::svm_multiclass_learn -c 100000 Feats/Feats.train.500k models/model.500k
::svm_multiclass_classify Feats/Feats.test.500k models/model.500k Prediction/pred.500k
perl Evaluation.pl Feats/Feats.test.500k Prediction/pred.500k > Results/stats.500k

cat Data/Tweets.train.500k | perl SelectRandom.pl 500000 50000 > Data/Tweets.train.50k
cat Data/Tweets.train.50k | perl TermExtraction.pl > Data/Terms.feats.50k
cat Data/Tweets.train.50k  | perl Tweets2Feats.pl Data/Terms.feats.50k > Feats/Feats.train.50k
cat Data/Tweets.test  | perl Tweets2Feats.pl Data/Terms.feats.50k > Feats/Feats.test.50k
svm_multiclass_learn -c 100000 Feats/Feats.train.50k models/model.50k
svm_multiclass_classify Feats/Feats.test.50k models/model.50k Prediction/pred.50k
perl Evaluation.pl Feats/Feats.test.50k Prediction/pred.50k > Results/stats.50k

cat Data/Tweets.train.50k | perl SelectRandom.pl 50000 5000 > Data/Tweets.train.5k
cat Data/Tweets.train.5k | perl TermExtraction.pl > Data/Terms.feats.5k
cat Data/Tweets.train.5k  | perl Tweets2Feats.pl Data/Terms.feats.5k > Feats/Feats.train.5k
cat Data/Tweets.test  | perl Tweets2Feats.pl Data/Terms.feats.5k > Feats/Feats.test.5k
svm_multiclass_learn -c 100000 Feats/Feats.train.5k models/model.5k
svm_multiclass_classify Feats/Feats.test.5k models/model.5k Prediction/pred.5k
perl Evaluation.pl Feats/Feats.test.5k Prediction/pred.5k > Results/stats.5k