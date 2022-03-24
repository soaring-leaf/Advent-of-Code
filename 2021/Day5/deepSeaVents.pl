#!/usr/bin/perl
use warnings;
use strict;

my @seaFloor; # 2-D Array to hold the 990 x 990 sea floor field
my $overlap = 0; # Count of positions that the vent lines overlap
my $max = 0; # Var to hold the larger of the Coords when mapping the sea floor
my $min = 0; # Var to hold the larger of the Coords when mapping the sea floor

# Initialize the seaFloor array
for(my $i=0; $i<990; $i++) {
    push(@seaFloor,[(0) x 990]);
}

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Inptu file $!";

while(<INPUT>) {
    chomp;
    my ($x1, $y1, $x2, $y2) = split(/[,\s->\s\/]+/);

    # Part 1 only considers horiz/vert lines
    if($x1 == $x2) {
        # run through Y coords and update seaFloor matrix
        if($y1 > $y2) {
            $max = $y1;
            $min = $y2;
        } else {
            $max = $y2;
            $min = $y1;
        }

        for(my $y=$min; $y <= $max; $y++) {
            $seaFloor[$x1][$y]++;
        }
    } elsif ($y1 == $y2) {
        # run through X coords and update seaFloor matrix
        if($x1 > $x2) {
            $max = $x1;
            $min = $x2;
        } else {
            $max = $x2;
            $min = $x1;
        }
        
        for(my $x=$min; $x <= $max; $x++) {
            $seaFloor[$x][$y1]++;
        }
    }
}

close(INPUT);

for(my $x=0; $x < 990; $x++) {
    for(my $y=0; $y < 990; $y++) {
        if($seaFloor[$x][$y] > 1) {
            $overlap++;
        }
    }
}

# Part 1 answer:
print "Deep Sea Vents overlap in $overlap places.\n\n";

# Part 2 answer:
#print "\n";

exit(0);
#==========================================================================
