#!/usr/bin/perl -w
#use warnings;

#print "@ARGV\n";
if (@ARGV == 1 and $ARGV[0] =~ /^\d+$/) {
	while ($line = <STDIN>) {
		$content{$line}++;
		if ($content{$line} eq $ARGV[0]) {
			print "Snap: $line";
			last;
		}
	}

}
else {
	die;
}

=pdd
foreach $k (sort keys %content) {
	print "$content{$k} <--------- $k";
}
=cut
