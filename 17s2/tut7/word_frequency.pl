#!/usr/bin/perl -w


while ($line = <STDIN>) {
	$line = lc $line;
	$line =~ s/[^a-z]/\ /g;
	$line =~ s/^\s*//;
	$line =~ s/\s+/\ /g;
	$line =~ s/\s*$//;
	foreach $word ($line =~ /[a-z]+/g) {
		$count{$word}++;
	}
	
}
@words = keys %count;
@sorted_words = sort {$count{$a} <=> $count{$b}} @words;
foreach $word (@sorted_words) {
	printf "%d %s\n", $count{$word}, $word;
}