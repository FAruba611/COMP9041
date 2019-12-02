#!/usr/bin/perl -w


#print "$ARGV[0]\n";
if (@ARGV != 1) {
	die;# "Usage: $0 <word>\n"; 
}


foreach $file (glob "lyrics/*") {
    #print "current file = $file\n";
	#print "$!\n";
    open my $f, '<', $file or die "can not open $file: $!";
	$select_cnt = 0;
	$total_cnt = 0;
	$artist = $file;
	$artist =~ s/.*\///;
	$artist =~ s/\.txt$//;
	$artist =~ s/_/ /g;
	
	#$song =~ s/\ +/\ /;
 	while ($line = <$f>) {
		$line = lc $line;
		$line =~ s/[^a-z]+/ /g;
		$line =~ s/\ \ +/ /g;
		#print "$line   --------->>>>>        ";
		#$a = $line =~ /^( *)([a-z]+)( *)$/g;
		#$a = $line =~ /[a-z]+/g;
		#print "$a\n";
		
		foreach $word ($line =~ /[a-z]+/g) {
			$total_cnt++;
			if ($word eq (lc $ARGV[0])) {
				$select_cnt++;
			}
		}
		
	}
	#print "----all $total_cnt\n";
	#print "++++sel $select_cnt\n";
	#$frequency = $select_cnt / $total_cnt;
	
	#printf "%4d/%6d = %.9f %s\n", $select_cnt, $total_cnt, $frequency, $artist;
	printf "log((%d+1)/%6d) = %8.4f %s\n", $select_cnt, $total_cnt, log(($select_cnt+1)/$total_cnt), $artist;
	#print "===============================================\n";
	close $f;
	
}
