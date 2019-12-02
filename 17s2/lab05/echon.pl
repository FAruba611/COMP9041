#!/usr/bin/perl -w

if (@ARGV == 2 and $ARGV[0] =~ /^[0-9]*$/ and $ARGV[1] =~ /^.*$/ ) {
   foreach ($c=0;$c<$ARGV[0];$c++) {
        print "$ARGV[1]";
        print "\n";
   }
}
elsif ($ARGV[0] !~ /^[0-9]*$/) {
    print "./echon.pl: argument 1 must be a non-negative integer\n";
    exit 1;
}

else {
    print "Usage: ./echon.pl <number of lines> <string>\n";
    exit 1;
}
