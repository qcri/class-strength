#########################################################################
## This script reads the prediction file of SVM multi-classifier along ##
## with test features file and computes different evaluation measures  ##
## and analyse the confusion matrix among different classes            ##
## Usage: perl Evaluate.pl Test.Feats Prediction                       ##
## Copyright: Walid Magdy - QCRI                                       ##
## Last modified: 25-2-2014                                            ##
#########################################################################

$usage = "perl Evaluate.pl Test.Feats Prediction\n";

$truthFile = $ARGV[0] or die $usage;
$predFile = $ARGV[1] or die $usage;

open(IN1, $truthFile) or die "Can't open $truthfile\n";
open(IN2, $predFile) or die "Can't open $predfile\n";

while($truth = <IN1>){
	$pred = $prediction = <IN2>;
	$truth =~ s/^(\d+)\s.+/\1/;
	$pred =~ s/^(\d+)\s.+/\1/;
	$conf{$truth}{$pred}++;
	$totalT{$truth}++;
	$totalP{$pred}++;
	$prediction =~ s/^\d+\s+//;
	$class = 1;
	while($prediction =~ /(\S+)/g){
		$score{$class++} = $1;
	}
	$rank = 0;
	loop:for $class (sort {$score{$b} <=> $score{$a}} keys %score){
		$rank++;
		if($class == $truth){
			$count{$rank}++;
			last loop;
		}
	}
}

$nclass = 0;
for $truth (sort {$a <=> $b} keys %totalT){
	$nclass++;
	$recall{$truth} = $conf{$truth}{$truth}/$totalT{$truth};
	$precision{$truth} = $conf{$truth}{$truth}/$totalP{$truth};
	$avgRecall += $recall{$truth};
	$avgPrecision += $precision{$truth};
	$accuracy += $conf{$truth}{$truth};
	$totaltest += $totalT{$truth};
	for $pred (sort {$a <=> $b} keys %totalT){
		print $conf{$truth}{$pred}+0, "\t";
	}
	print "$total{$truth}\n";
}

print "\n\n";

for $rank (sort {$a <=> $b} keys %count){
	print "$rank\t$count{$rank}\n";
}

print STDERR "Avg. Recall = ",$avgRecall/$nclass,"\n";
print STDERR "Avg. Precision = ",$avgPrecision/$nclass,"\n";
print STDERR "Accuracy = ",$accuracy/$totaltest,"\n";