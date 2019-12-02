#!/usr/bin/perl -w

@temp = ();
foreach my $prefix (@ARGV) {
	#print $prefix;
	#print "\n";
	my @course_info = split(//,$prefix);
	#print $course_info[0];
	#print "\n";
	open $f, '-|', "wget -q -O- http://www.timetable.unsw.edu.au/current/${prefix}KENS.html" or die; 
	while (<$f>) { 
		#if /$course_info[0]$course_info[1]$course_info[2]$course_info[3]\d\d\d\d/ {
		#	print $1,"\n";
		#}
		if (/($course_info[0]$course_info[1]$course_info[2]$course_info[3]\d\d\d\d)/) {
			$item = $1;
			if (grep {$_ eq $item} @temp) {
				next;
			}
			push @temp, $item;
			#print "$1\n" ;
		}
		
	}
	close $f;
}

foreach $x (@temp) {
	print $x;
	print "\n";
}

