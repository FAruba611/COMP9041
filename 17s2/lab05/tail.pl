#!/usr/bin/perl -w

$tail_default = 10; 
#print("argv@ @ARGV");
#print("\n");

if (@ARGV > 0 && $ARGV[0] =~ /-([0-9]+)/) {
    #print("tail num $tail_default\n");
    #print("argv[0]--> $ARGV[0]\n");
    ($tail_default = $ARGV[0]) =~ s/-//;; 
    @arraytmp = reverse(@ARGV);
    pop @arraytmp;
    @ARGV = reverse(@arraytmp);
} 
#print("argv@ @ARGV\n");

if (@ARGV == 0) { 
    #print("-----------\n");
    @lines = <>;
    #print("lines@:  @lines\n");
    $first = @lines - $tail_default; 
    if ($first < 0) {
        $first = 0;
    }
    print @lines[$first..$#lines]; 
} 
else { 
    $shs = (@ARGV > 1); 
    #print("++++++++++++\n");
    
    foreach $file (@ARGV) { 
        
        open my $file, '<', $file or die "$0: can't open $file\n";
        
        if ($shs) {
          print "==>";
          print $file;
          print "<==\n";
          
        }
        @lines = <$file>; 
        $first = @lines - $tail_default;
        if ($first < 0) {
          $first = 0
        } 
        print @lines[$first..$#lines]; 
        close $file; 
    } 
}

