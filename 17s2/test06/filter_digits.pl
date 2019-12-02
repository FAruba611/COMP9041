#!/usr/bin/perl -w

$cnt = 1;

while ($current_line = <STDIN>) {
	$current_line =~ s/[0-9\n]//g;
	#print "current line = $current_line\n";
	#print "line_tag = $cnt\n";
	$dic_line{$cnt} = $current_line;
	$cnt++;
}


foreach $line_tag (sort keys %dic_line) {
	print "$dic_line{$line_tag}\n";
}

