#!/usr/bin/perl
use warnings;
use strict;

my $fullOverLap = 0; # count of overlapping cleaning assignments
my $partOverLap = 0; # Part 2 - count of any overlap

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    my ($e1,$e2) = split(',');

    my ($e1St, $e1Fin) = split('-',$e1);
    my ($e2St, $e2Fin) = split('-',$e2);
    
    # Part 1 - full overlap
    if(($e1St >= $e2St && $e1Fin <= $e2Fin) || ($e2St >= $e1St && $e2Fin <= $e1Fin)) {
        $fullOverLap++;
    }

    # Part 2 - Partial overlap
    if($e1St <= $e2Fin && $e1Fin >= $e2St) {
        $partOverLap++;
    }
}

close(INPUT);

print "There are $fullOverLap Elves that have fully overlapping areas.\n";

print "There are $partOverLap assignments that partially overlap.\n\n";

exit(0);
#==========================================================================
