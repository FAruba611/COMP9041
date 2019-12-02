#!/usr/bin/perl -w

use POSIX;

open my $f ,'<', $ARGV[$#ARGV];
$cnt=0;
while (my $read_line = <$f>) {
	$dict{$cnt} = $read_line;
	$cnt++;
}
close $f;

#sort %dict;

$len = keys %dict;
if ($len > 0){
	if ($len % 2 eq 0) {
		print "$dict{floor(($len-1)/2)}";
		print "$dict{ceil(($len-1)/2)}";
	}
	else {
	print "$dict{($len-1)/2}";
	}
}



=pod
while (($keys,$_) = each %dict){
	print "key $keys => val $dict{$keys}\n";
}
=cut
