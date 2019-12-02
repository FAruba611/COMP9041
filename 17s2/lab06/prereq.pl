#!/usr/bin/perl -w

$year = 2017;
$url_p = "http://www.handbook.unsw.edu.au/postgraduate/courses/$year";
$url_u = "http://www.handbook.unsw.edu.au/undergraduate/courses/$year";

foreach $input_course (@ARGV) {
	open my $f, '-|', "wget -q -O- $url_u/$input_course.html $url_p/$input_course.html" or die;
	#while (<$f>) {
	#	print "$_";
	#}
	while ($line = <$f>) {
		#if ($line =~ /pre.?(requisite)?(.?:|\s+[A-Z]{4}\d{4})/i) {
		if ($line =~ /Prerequisites?(:.*\s+[A-Z]{4}[1-9]\d{3})/) {
			#print "*******************************************************\n";
			#print "---->>> before change:\n$line\n";
			$line = uc $line;
			$line =~ s/\s+/ /g;
			#$line =~ s/\d*&nbsp;//g;
			#print "---->>> rid space:\n$line\n";
			$line =~ s/<[^>]*>/ /g;
			#print "---->>> rid <?>:\n$line\n";
			$line =~ s/EXCLUDE.*/ /i;
			#print "---->>> rid EXC:\n$line\n";
			$line =~ s/CSS.*/ /g;
			#print "---->>> rid CSS:\n$line\n";
			#print "---->>> final:\n$line\n";

			my @courses = $line =~ /([A-Z]{4}[1-9]\d{3})/g;
			#print "course = @courses\n";
			push @prereqs, @courses;
		}
	}
	close $f;
}


foreach $k (sort @prereqs) {
	print "$k\n";
}
