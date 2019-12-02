#!/usr/bin/perl -w

#print ("@ARGV\n");
#print ("$ARGV[0]\n");
#print ("$ARGV[1]\n");
#print ("$ARGV[2]\n");
@tem = ();
foreach $item (@ARGV) {
	if (grep {$_ eq $item} @tem) {
		next;
	}
	push @tem, $item;
}

print "@tem\n";

	

