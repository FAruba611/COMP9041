#!/usr/bin/perl -w

$current = 2017;
$target_url = "http://timetable.unsw.edu.au/$current";
@final = ();
foreach $course (@ARGV) {
	#print $course;
	#print "\n";
	open my $f, '-|', "wget -q -O- $target_url/$course.html";
	$find_tag = "False";
	$valid_line = 0;
	$cnt = 0;
	$prefix = "Lecture";
	$valid_session_info = "";
	while($line = <$f>) {
		$cnt++;
		#print "-----------------------------------------------\n";
		@line_array = split(/$/,$line);
		if ($line =~ /a href=.*>$prefix</) {
			$find_tag = "True";
			
		}
		
		if ($find_tag eq "True") {
			$valid_line++;
			if ($cnt > 200 and $cnt < 340) {
				#print "$cnt\n";
				#print " current line = $line";
				#print "line num = $valid_line\n";
				#print "$valid_session_info\n";
			
			}
			
		}
		if ($find_tag eq "True" and $valid_line eq 2) {
			$valid_session_info = $line;
			$valid_session_info =~ s/<.*?>//g;
			$valid_session_info =~ s/^\s*//g;
			$valid_session_info =~ s/\s*$//g;
			$valid_session_info =~ s/T/S/g;
			#print "-----------------------\n";
			#print "$valid_session_info\n";
		}
		if ($find_tag eq "True" and $valid_line eq 7) {
			#print "-----------------------\n";
			#print "line = $line\n";
			if ($line =~ /(Weeks:)/) {
				#print "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n";
				
				#print "$cnt fucking result = @line_array";
				$valid_t_info = $line_array[0];
				$valid_t_info =~ s/<.*?>//g;
				$valid_t_info =~ s/^\s*//g;
				$valid_t_info =~ s/\s*$//g;
				
				#print "$cnt fucking result = $valid_t_info\n";
				$item = "$course: $valid_session_info $valid_t_info\n";
				if (grep {$_ eq $item} @final) {
					$find_tag = "False";
					$valid_session_info = "";
					$valid_line = 0;
					next;
				}
				push @final, $item;
				
			}
			$find_tag = "False";
			$valid_session_info = "";
			$valid_line = 0;
		}

	}
	close $f;
}
foreach $elem (@final) {
	print "$elem";
}
