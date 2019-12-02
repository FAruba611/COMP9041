#!/usr/bin/perl -w


if (@ARGV == 0) {
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
			$frequency{$word}{$_}++;
			$n_words{$powordet}++;
			if ($word eq (lc $ARGV[0])) {
				$select_cnt++;
			}
		}
		
	}
	#print "----all $total_cnt\n";
	#print "++++sel $select_cnt\n";
	#$frequency = $select_cnt / $total_cnt;
	
	#printf "%4d/%6d = %.9f %s\n", $select_cnt, $total_cnt, $frequency, $artist;
	#printf "log((%d+1)/%6d) = %8.4f %s\n", $select_cnt, $total_cnt, log(($select_cnt+1)/$total_cnt), $artist;
	#print "===============================================\n";
	close $f;
	
}

$d = 0
@singer_set = keys %frequency;
foreach $file (@ARGV) {
	my %log_probability; 
	if ($file eq '-d') { 
		$d = -1; 
		next; 
	}
	open my $f, '<', $file or die "can not open $file: $!";
	while ($line = <$f>) {
		$line = lc $line;
		foreach $word ($line =~ /[a-z]+/g) {
			foreach $singer (@singer_set) {
				$log_probability{$singer} += log((($frequency{$singer}{$word}||0) + 1)/$n_words{$singer});
				} 
			} 
		}
		close $f; 
		@sorted_singers = sort {$log_probability{$b} <=> $log_probability{$a}} @singer_set;
		if ($debug!=-1) { 
			foreach $singer (@sorted_singers) { 
				printf "%s: log_probability of %.1f for %s\n", $file, $log_probability{$singer}, $singer; 
			} 
		} 
		printf "%s most resembles the work of %s (log-probability=%.1f)\n", $file, $sorted_singers[0], $log_probability{$sorted_singers[0]}; 
	}


