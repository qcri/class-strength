open(IN,"resources/Categories.txt") or die "Can't find categories mapping file\n";
while(<IN>){
	if(/(\d+)\t(.+)/){
		$id{$2} = $1;
	}
}
close(IN);

#open(IN, "resources/StopDialect.txt") or die "Can't find stop words list\n";
while(<IN>){
	if(/(\S+)/){
		$stop{$1} = 1;
	}
}
$stop{"<s>"} = 1;
close(IN);

while(<STDIN>){
	if(/([^\t]+)\t([^\t\n]+)$/ && exists $id{$2}){
		$tweet = $1;
		$class = $id{$2};
		while($tweet =~ /(\S+)/g){
			#if(!exists $stop{$1}){
				$terms{$class}{$1}++;
				$DF{$1}++;
				$total++;
			#}
		}
	}
}

for $class (keys %terms){
	$n=0;
	loop:for $term (sort {$terms{$class}{$b}/$DF{$b} <=> $terms{$class}{$a}/$DF{$b}} keys %{$terms{$class}}){
		if($n++ >= 10000){
			last loop;
		}
		$tfidf{$class}{$term} = $terms{$class}{$term}*log($total/$DF{$term});
	}
}

$n = 0;
for $class (keys %tfidf){
	for $term (sort {$tfidf{$class}{$b}/$DF{$b} <=> $tfidf{$class}{$a}/$DF{$b}} keys %{$tfidf{$class}}){
		if(!exists $feats{$term}){
			$feats{$term}=1;
			$n++;
			print "$n\t$term\n";
		}
	}
}
