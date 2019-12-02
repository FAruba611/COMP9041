#!/usr/bin/perl -w

sub max{
	my $mx = $_[0];
	for my $e(@_) {
		$mx = $e if ($e > $mx);
	}
	return $mx;
}

$cnt = 1;
@data_array = ();

while ($line = <STDIN>) {
	my @num_array = ();
	$line =~ s/^(\s)*//;
	$line =~ s/\ +/\ /g;
	if ($line =~ /-?\.?[0-9]+/) {
		
		$item = $line;
		$item =~ s/[^-.0-9]/ /g;
		$item =~ s/^(\s)*//;
		$item =~ s/\ +/\ /;
		#print "item = $item\n";
		@num_array = split(/ /,$item);
		#print "@num_array";
		foreach $num (@num_array) {
			#print "$num\n";
			$num = $num + 0;
			# add item to array
		#push @num_array, $item;
		}
		$max = max(@num_array);
		#print "max = $max\n";
	
		$data_hash{$cnt} = $max;
		$content_hash{$cnt} = $line;
		push @data_array, $max;
	}	
	
	#print "num_array = @num_array\n";
	$cnt++;
}
#print "data_array = @data_array\n";
$max_occur_num = max(@data_array);
#print "max_occur_num = $max_occur_num\n";
foreach $key (sort keys %content_hash) {
	#print "key = $key\n";
	if ($data_hash{$key} eq $max_occur_num) {
		print "$content_hash{$key}";
	}
	
}
