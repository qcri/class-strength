$remaining = $ARGV[0] or die "Please specify the number of lines\n";
$select = $ARGV[1] or die "Please specify the number of lines to be selected at random\n";
$selected = 0;

while(<STDIN>){
	if(rand()<($select-$selected)/$remaining){
		print;
		$selected++;
	}
	$remaining--;
}