#!/usr/bin/perl -w

$line_cnt = 1;
%dict = ();
while ($line = <STDIN>) {
	$line =~ s/\n//;
	$line =~ s/(\s+)/\ /g;
	$line =~ s/^\s*//;
	$line =~ s/\s*$//;
	#print "++++++++++",$line,"\n";
	@word_set = split(/\ /,$line);
	#print "+-----+",@word_set,"\n";
	@final_result = ();

	foreach $word (@word_set) {
		%cnt_dict = ();
		@tem = ();
		#print "word = ",@word,"\n";
		$word_tmp = lc $word;
		@char_set = split(m//,$word_tmp);
		#print "char = ",@char_set,"\n";

		foreach $char (@char_set) {
			$cnt_dict{$char}++;
		}
		

		foreach $item (sort keys %cnt_dict) {
            #print "000000",$item,"===>",$cnt_dict{$item},"\n";
			if (grep {$_ eq $cnt_dict{$item}} @tem) {
				next;
			}
			push @tem, $cnt_dict{$item};
		}
		#print "=tem=: @tem\n";
		if ($#tem + 1 == 1) {

			push @final_result, $word;
		}
	}
	$dict{$line_cnt} = "@final_result";#remember to add "" or may show len(array)
	$line_cnt++;
}

foreach $k (sort keys %dict) {
	
	print "$dict{$k}";
	print "\n";
	
}
