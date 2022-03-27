#!/usr/bin/perl
use warnings;
use strict;

my $lowCount = 0; # Counter for the low points found (Part 1)
my $riskPoints = 0; # Sum of the Low Points' risk levels (height + 1)
my @caveMap; # 2-D array for the topographical cave map
my $rLen = 0; # Width of the cave (row length)

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my @line = split('',$_);
    push(@caveMap,\@line);

    $rLen = scalar(@line);
}

close(INPUT);

for(my $col=0; $col < scalar(@caveMap); $col++) {
    for(my $row=0; $row < $rLen; $row++) {
        my $test = 1;

        # check surrounding coords N, E, S, W
        if($col > 0 && $caveMap[$col][$row] >= $caveMap[$col-1][$row]) {
            $test = 0;
        }
        if($test && $row < $rLen-1 && $caveMap[$col][$row] >= $caveMap[$col][$row+1]) {
            $test = 0;
        }
        if($test && $col < scalar(@caveMap)-1 && $caveMap[$col][$row] >= $caveMap[$col+1][$row]) {
            $test = 0;
        }
        if($test && $row > 0 && $caveMap[$col][$row] >= $caveMap[$col][$row-1]) {
            $test = 0;
        }

        if($test) {
            $lowCount++;
            $riskPoints += $caveMap[$col][$row] + 1;
        }
    }
}

# Part 1 answer:
print "Number of low points in the cave: $lowCount\n";
print "Risk Rating of all the low points: $riskPoints\n";

# Part 2 answer:
print "\n\n";

exit(0);
#==========================================================================
