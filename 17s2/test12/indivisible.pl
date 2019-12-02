#!/usr/bin/perl -w

@final_array = ();
while ($line = <STDIN>) {
	$line =~ s/^\s*//;
	$line =~ s/\s+/ /g;
	$line =~ s/\s*$//;
	@array = split " ", $line;
	foreach $arg (@array) {
		push @final_array, $arg;
	}
}

$i = 0;
while ($i <= $#final_array) {
	$final_array[$i] = $final_array[$i] + 0;
	
	$i++;
}

$m = 0;


while ($m <= $#final_array) {
	$n = 0;
	while ($n <= $#final_array) {
		
		#print "current two value: $final_array[$m],$final_array[$n]\n";
		if ($final_array[$m] % $final_array[$n] eq 0) {
			#print "+++++\n";
			$count[$final_array[$m]]++;
			
			
		}
		$n++;
	}
	if ($count[$final_array[$m]] gt 1)  {
				
	}
	else {
		push @lis, $final_array[$m];
	}
	$m++

}

foreach $item (sort {$a <=> $b}@lis) {
	print "$item ";
}
print "\n";
