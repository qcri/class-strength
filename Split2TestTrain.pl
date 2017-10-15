$remaining = $ARGV[0] or die "Please specify the total number of tweets\n";
$select = $ARGV[1] or die "Please specify the total number of tweets for training\n";
$selected = 0;

open(out, ">Tweets.test");
open(out2, ">Tweets.train");
while(<STDIN>){
	if(rand()<($select-$selected)/$remaining){
		print out2;
		$selected++;
	}
	else{
		print out;
	}
	$remaining--;
}
close(out);
close(out2);