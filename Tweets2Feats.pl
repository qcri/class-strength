################################################################
## Converts tweets to feats.                                  ##
## Usage: cat tweets | perl Tweets2Feats.pl feats.txt > feats ##
## Last modified: 3/3/2014                                    ##
################################################################

open(IN, $ARGV[0]) or die "Please specify the terms features file\n";
binmode IN, ':utf8';
binmode STDOUT, ':utf8';
while(<IN>){
	if(/(\d+)\t(\S+)/){
		$feat{$2} = $1;
	}
}
close(IN);

open(IN,"resources/Categories.txt") or die "Can't find categories mapping file\n";
while(<IN>){
	if(/(\d+)\t(.+)/){
		$id{$2} = $1;
	}
}
close(IN);

binmode STDIN, ':utf8';
while(<STDIN>){
	if(/^(\d+).+\t([^\t]+)\t([^\t\n]+)$/ && exists $id{$3}){
		$tid = $1;
		$tweet = $2;
		$class = $id{$3};
		%feats = ();
		while($tweet =~ /(\S+)/g){
			$w = $1;
			if(exists $feat{$w}){
				$feats{$feat{$w}}++;
			}
		}
		print "$class\t";
		for $f (sort {$a <=> $b} keys %feats){
			print "$f:$feats{$f} ";
		}
		print "#$tid\n";
	}
}