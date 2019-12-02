#!/usr/bin/perl -w

$i = 0; 
while (<STDIN>) {
	foreach (/[a-z]+/gmi) { 
		$i++; 
		}
	}
print "$i\ words\n"