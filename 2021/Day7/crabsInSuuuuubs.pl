#!/usr/bin/perl
use warnings;
use strict;

my %posCount; # Hash to determine if multiple crabs start in same position
my %pt2FuelCost; # Calculated cost to move a given # of positions for Part 2
my $multiFlag = 0; # flag for multiple crabs in one spot
my $maxPos = 0; # highest position
my $minCost = -1; # Total cost of min Fuel used
my $bestPos = 0; # Best Position to align the crabs
my $minPt2Cost = -1; # Min Fuel for Pt2
my $bestPosPt2 = 0; # Best Position for Pt2

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

# Part 2 - Calculate the cost to move a given number of positions for easy lookup later
for(my $i=0; $i <= $maxPos; $i++) {
    $pt2FuelCost{$i} = getFuelCostPt2($i);
}

# Run through positions 0 to maxPos
# for each position, determine fuel cost for crabs in each position of the hash
# Find if current position check is best based on min fuel cost
for(my $pos=0; $pos <= $maxPos; $pos++) {
    my $currFuel = 0;
    my $currFuelPt2 = 0;
    
    foreach my $crabs (keys(%posCount)) {
        $currFuel += abs($pos - $crabs) * $posCount{$crabs};
        $currFuelPt2 += $pt2FuelCost{abs($pos - $crabs)} * $posCount{$crabs};
    }

    if($currFuel < $minCost || $minCost == -1) {
        $minCost = $currFuel;
        $bestPos = $pos;
    }

    if($currFuelPt2 < $minPt2Cost || $minPt2Cost == -1) {
        $minPt2Cost = $currFuelPt2;
        $bestPosPt2 = $pos;
    }
}

# Part 1 answer:
print "Best position is $bestPos, costing $minCost\n";

# Part 2 answer:
print "New best position is $bestPosPt2, costing $minPt2Cost\n\n";

exit(0);
#==========================================================================
sub getFuelCostPt2 {
    my $cost = 0;
    my $moves = $_[0];

    for(my $m=$moves; $m > 0; $m--) {
        $cost += $m;
    }

    return $cost;
}