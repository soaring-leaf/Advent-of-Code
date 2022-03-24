#!/usr/bin/perl
use warnings;
use strict;

my @seaFloor; # 2-D Array to hold the 990 x 990 sea floor field
my $overlap = 0; # Count of positions that the vent lines overlap
my $max = 0; # Var to hold the larger of the Coords when mapping the sea floor
my $min = 0; # Var to hold the larger of the Coords when mapping the sea floor
my $xFlag = 1; # Directional Flag for X Coord: 1 = increase, -1 = decrease
my $yFlag = 1; # Directional Flag for Y Coord.

# Initialize the seaFloor array
for(my $i=0; $i<990; $i++) {
    push(@seaFloor,[(0) x 990]);
}

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Inptu file $!";

while(<INPUT>) {
    chomp;
    my ($x1, $y1, $x2, $y2) = split(/[,\s->\s\/]+/);

    #print "($x1,$y1) x ($x2,$y2)\n";

    # update the flags based on the given Coords
    if($y1 > $y2) {
        $max = $y1;
        $min = $y2;
        $yFlag = -1;
    } 
    
    if($y1 < $y2) {
        $max = $y2;
        $min = $y1;
        $yFlag = 1;
    }
    
    if($x1 > $x2) {
        $max = $x1;
        $min = $x2;
        $xFlag = -1;
    }
    
    if($x1 < $x2) {
        $max = $x2;
        $min = $x1;
        $xFlag = 1;
    }

    # Part 1 only considers horiz/vert lines
    # If one set of coords is the same, use the Max/Min values
    # Otherwise, it's a diagnal and X/Y should be used
    if($x1 == $x2) {
        # run through Y coords and update seaFloor matrix
        for(my $y=$min; $y <= $max; $y++) {
            $seaFloor[$x1][$y]++;
        }
    } elsif ($y1 == $y2) {
        # run through X coords and update seaFloor matrix
        for(my $x=$min; $x <= $max; $x++) {
            $seaFloor[$x][$y1]++;
        }
    } else {
        # Part 2 - account for the diagnals
        while($x1 != $x2) {
            $seaFloor[$x1][$y1]++; # Update sea map

            # increase/decrease along the diagnal for the next position
            $x1 += 1 * $xFlag;
            $y1 += 1 * $yFlag;
        }

        $seaFloor[$x1][$y1]++; # Update sea map for final Coord position
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

# Part 2 answer:
print "Deep Sea Vents overlap in $overlap places.\n\n";

exit(0);
#==========================================================================
