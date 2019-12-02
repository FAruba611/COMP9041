#!/usr/bin/perl -w

if (@ARGV != 1) {
	die "Usage: $0 <whale species>\n"
	
}
$species_src = $ARGV[0];
#print $species_src;
$total_num = 0;
$n_cnt = 0;
while ($line = <STDIN>) {
	#print $line;
	if ($line =~ /^\s*(\d+)\s*(.+)$/) {
		$num = $1;
		$content = $line;
		$content =~ s/^\ *\d+\ *//g;
		$content =~ s/\n//g;
		$species_src =~ s/\ +/\ /g;
		#print "$content\n";
		#print "$species_src\n";
		if ($content eq $species_src) {
			#print "------------------------------------------\n";
			$n_cnt++;
			$total_num+=$num;
		}
	}
}
print "$species_src observations: $n_cnt pods, $total_num individuals\n";
