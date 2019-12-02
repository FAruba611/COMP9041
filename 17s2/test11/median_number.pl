#!/usr/bin/perl -w

die if (@ARGV == 0);
#print ("---$#AGRV---\n");

$line = "@ARGV";
@line_arr = ();
$line =~ s/^\s*//;
$line =~ s/\s+/\ /g;
$line =~ s/\s*$//;

foreach $arg (split(/\ /,$line)) {
	$arg = $arg + 0;
	push @line_arr, $arg;
	
}
my @sorted_line_arr = sort {$line_arr[$a] <=> $line_arr[$b]} 0..$#line_arr;


$cnt = 0;
foreach $item (@sorted_line_arr) {
	if ($cnt eq $#line_arr / 2) {
		print $line_arr[$item];
		print "\n";
	}
	$cnt++;
}
