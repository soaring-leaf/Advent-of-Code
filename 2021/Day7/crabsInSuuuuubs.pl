#!/usr/bin/perl
use warnings;
use strict;

my %posCount; # Hash to determine if multiple crabs start in same position
my $multiFlag = 0; # flag for multiple crabs in one spot
my $maxPos = 0; # highest position
my $minCost = -1; # Total cost of min Fuel used
my $bestPos = 0; # Best Position to align the crabs

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my @initCrabs = split(',');

    # find max position and determine crab positions
    foreach my $crabs (@initCrabs) {
        if(exists($posCount{$crabs})) {
            $posCount{$crabs}++;
        } else {
            $posCount{$crabs} = 1;
        }

        if($maxPos < $crabs) {
            $maxPos = $crabs;
        }
    }

    print "Highest position of a crab is $maxPos\n";
}

close(INPUT);

# Determine if multiple crabs are starting in a given position --- Yes, there are
foreach my $p (keys(%posCount)) {
    if($posCount{$p} > 1) {
        $multiFlag++;
        #print "Multiple crabs in position $p: $posCount{$p} \n";
    }
}

if($multiFlag) {
    print "There are multiple crabs given some(or all) positions! \n";
}

# Part 1
# Run through positions 0 to maxPos
# for each position, determine fuel cost for crabs in each position of the hash
# Find if current position check is best based on min fuel cost
for(my $pos=0; $pos <= $maxPos; $pos++) {
    my $currFuel = 0;
     foreach my $crabs (keys(%posCount)) {
         $currFuel += abs($pos - $crabs) * $posCount{$crabs};
     }

     if($currFuel < $minCost || $minCost == -1) {
         $minCost = $currFuel;
         $bestPos = $pos;
     }
}

# Part 1 answer:
print "Best position is $bestPos, costing $minCost\n";

# Part 2 answer:
#print "\n\n";

exit(0);
#==========================================================================
