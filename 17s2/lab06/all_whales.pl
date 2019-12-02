#!/usr/bin/perl -w

while ($line = <STDIN>) {
	$line = lc $line;
	if ($line =~ /^\s*(\d+)\s*(.+)$/) {
		$num = $1;
		#print "num = $num\n";
		$content = $line;
		$content =~ s/^\s*\d+\s*//g;
		
		
		$content =~ s/s(\s*)$/\n/g;
		
		#print "species = $content";
		my $species = "$content";
		$species =~ s/\s+/ /g;
		$species =~ s/\s+$//g;
		#print "after chuli: $species";
		$pods{$species}++;
		$idiv{$species}+=$num;

	}
	else {
		print "Sorry couldn't parse: $line";
	}
	

}

foreach $item (sort keys %pods) {
	$output_species = $item;
	$output_species =~ s/\n//;
	print "$output_species observations: $pods{$item} pods, $idiv{$item} individuals\n";
}
