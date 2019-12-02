#!/usr/bin/perl -w

while ($line = <STDIN>) {
    #$line =~ tr/A-Z/a-z/;
    $line = lc $line;
    $line =~ s/\W/\ /g;
    $line =~ s/^\s*//;
    $line =~ s/\s*$//;
    $line =~ s/\s+/\ /;
    @wordarr = split(" ",$line);
    foreach $word (@wordarr) {
        $count{$word}++;
    }
}
@words = keys %count;
@sorted_words = sort {$count{$a} <=> $count{$b}} @words;
foreach $word (@sorted_words) {
    printf "%d %s\n", $count{$word}, $word;
}
