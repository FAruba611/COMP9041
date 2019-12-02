#!/usr/bin/perl -w

$cnt = 0;
while ($line = <STDIN>) {
	$line =~ s/\ \ */\ /g;
	$line =~ s/\n//;
	$container{$cnt} = $line;
	#print "current $cnt ===>> $container{$cnt}\n";
	$cnt++;
	#print "current line = $line\n";
}
#print "current container: ";
#print %container;
#print "\n";
$cnt = 0;
while (($_, $_) = each %container) {
	#print "_---------------_\n";
	my @te = split(/\ /,$container{$cnt});
	my @sort_te = sort @te;
	print "@sort_te";
	
	print "\n";
    $cnt++;
}
