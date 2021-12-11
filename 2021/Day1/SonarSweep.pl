#!/usr/bin/perl
use warnings;
use strict;

my $curr = 0; # triple depth currently being calculated
my $prev = -1; # The previous number/calc
my $totalInc = 0; # Total times the depth increases
my @depthList; # Array to hold all the scanned depths


open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    if($prev != -1 && $prev < $_) {
        $totalInc++;
    }

    $prev = $_;

    # build the entire list for Part 2
    push(@depthList,$_);
}

close(INPUT);

# Part 1 answer:
print "Scanner found the depth increases $totalInc times.\n";

# reset vars for Part 2
$totalInc = 0;
$prev = $depthList[0] + $depthList[1] + $depthList[2];

# Part 2: Use full list to get the triple sum sliding window
for(my $i=3;$i<scalar(@depthList);$i++) {
    $curr = $depthList[$i] + $depthList[$i-1] + $depthList[$i-2];

    if($prev < $curr) {
        $totalInc++;
    }

    $prev = $curr;
}

# Part 2 answer:
print "There are $totalInc depth increases using a 3 count sliding window.\n";

exit(0);
#==========================================================================
