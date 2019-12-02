#!/usr/bin/perl -w
=pod
sub del_redundant_blank {
	my $l = $_[0];
	#print("=-=-=-=-=-= $l");
	$l =~ s/^\ +//;
	$l =~ s/\ +/\ /g;
	return $l;
}
=cut
$file = $ARGV[0];


open my $f, $file or die "cannot open for: $!";
while ($line = <$f>) {
	#print "current line => $line";

	# ------ case1: the substitution of precompile head
	if ($line =~ /^\s*#!\/bin\/(ba|t)?sh\s*$/) {
		#$line = del_redundant_blank($line);
		$line =~ s/\/bin/\/usr\/bin/;
		$line =~ s/(ba|t)?sh/perl -w/;
		#print "after change => $line\n";
	}

	# ------ case2: set num value
	if ($line =~ /[a-zA-Z_]+=\$?[0-9a-zA-Z_]+/) {
		$line =~ s/\$//g;
		$line =~ s/([a-zA-Z_]+)/\$$1 /g;
		$line =~ s/(=)/$1\ /;
		$line =~ s/($)/\;$1/;
		#print "after change => $line\n";

	}

	# ------ case3: start of condition or loop
	if ($line =~ /^\s*(while|if)\s+/) {
		$line =~ s/([a-zA-Z_]+)/\$$1/g;
		$line =~ s/\$while/while/g;
		$line =~ s/\$if/if/g;
		$line =~ s/\(//;
		$line =~ s/\)//;
		#print "after change => $line\n";
	}
	# --{
	if ($line =~ /^\s*do\s*$/) {
		$line =~ s/do/\{/;
		#print "after change => $line\n";
	}
	if ($line =~ /^\s*done\s*$/) {
		$line =~ s/done/\}/;
		#print "after change => $line\n";
	}

	# ------ case4: condition
	if ($line =~ /^\s*then\s*$/) { 
		$line =~ s/then/\{/;
		#print "after change => $line\n";
	}
	if ($line =~ /^\s*elif\s*$/) {
		$line =~ s/elif/\}elsif /;
		#print "after change => $line\n";
	}
	if ($line =~ /^\s*else\s*$/) {
		$line =~ s/else/\}else \{/;
		#print "after change => $line\n";
	}
	# --}
	if ($line =~ /^\s*fi\s*$/) {
		$line =~ s/fi/\}/;
		#print "after change => $line\n";
	}

	# ------ case5: content inside condition or loop
	if ($line =~ /^\s*[a-zA-Z_]+=(\$)\(\(.+\)\)\s*$/) {
		
		$line =~ s/\$//g;
		$line =~ s/\(//g;
		$line =~ s/\)//g;
		$line =~ s/([a-zA-Z_]+)/\$$1 /g;
		$line =~ s/($)/\;$1/;
		#print "after change => $line\n";
		
	}

	# ------ case6: echo -> print "";
	if ($line =~ /^\s*echo\s+.+/) {
		$line =~ s/echo\ (.+)/print \"$1\\n\";/;
		#print "after change => $line\n";
	}
		
	#print "after change => $line";
	print $line;
}
close $f;


=pod var+$
$L = "i = j + f + s + xewr + 1";
print("before ===>   $L\n");
$L =~ s/([a-z]+)/\$$1/g;
print("$1\n");

print("after  ===>   $L\n");
=cut

#echo Sum of the integers $start .. $finish = $sum
#print "Sum of the integers $start .. $finish = $sum\n";
