#!/usr/bin/perl -w

$target_file = $ARGV[0];

open my $f, $target_file or die;

while (my $line = <$f>) {
	$line =~ s/[aeiouAEIOU]//g;
	push @line_arr, $line;
	#print("$line");
}
close $f;

open("RESULT", ">$target_file");
foreach $item (@line_arr) {
	print RESULT "$item";
}
