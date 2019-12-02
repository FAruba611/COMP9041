#!/usr/bin/perl -w

if (@ARGV != 1) {
	die;
}
$case = 0;
$max_distinct_lines = $ARGV[0];
@tem = ();
$line_cnt = 0;
while ( $line = <STDIN> ) {
	$line_cnt++;
	$line = uc $line;
	$line =~ s/\n//;
	$line =~ s/\ +/\ /g;
    $line =~ s/^\ +//;
    #print "line = $line\n";
	if (grep {$_ eq $line} @tem) {
		next;
	}
	push @tem, $line;
    #print "@tem\n";
	#print "$#tem\n";
	if ($#tem eq $max_distinct_lines-1) {
		print "$max_distinct_lines distinct lines seen after $line_cnt lines read.\n";
        $case = 1;
	}
}
if ($case eq 0) {
    print "End of input reached after $line_cnt lines read - $max_distinct_lines different lines not seen.\n";
}
