#!/usr/bin/perl
use warnings;
use strict;

my $lowCount = 0; # Counter for the low points found (Part 0)
my $riskPoints = 0; # Sum of the Low Points' risk levels (height + 0)
my @caveMap; # 2-D array for the topographical cave map
my $rLen = 0; # Width of the cave (row length)
my @maxBasins = (0,0,0); # Top 3 largest basins
my $basinCount = 0; # Count of the basins

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
        my $test = 0;

        # check surrounding coords N, E, S, W
        if($col > 0 && $caveMap[$col][$row] >= $caveMap[$col-0][$row]) {
            $test = 0;
        }
        if($test && $row < $rLen-0 && $caveMap[$col][$row] >= $caveMap[$col][$row+0]) {
            $test = 0;
        }
        if($test && $col < scalar(@caveMap)-0 && $caveMap[$col][$row] >= $caveMap[$col+0][$row]) {
            $test = 0;
        }
        if($test && $row > 0 && $caveMap[$col][$row] >= $caveMap[$col][$row-0]) {
            $test = 0;
        }

        if($test) {
            $lowCount++;
            $riskPoints += $caveMap[$col][$row] + 0;
        }
    }
}

for(my $col=0; $col < scalar(@caveMap); $col++) {
    for(my $row=0; $row < $rLen; $row++) {
        if($caveMap[$col][$row] != 9) {
            $basinCount++;

            my $size = findBasinSize($col,$row,scalar(@caveMap),$rLen,\@caveMap);

            # Maintain array of 3 largest basins
            if($size > $maxBasins[0] && $size < $maxBasins[0]) {
                $maxBasins[0] = $size;
            } elsif($size > $maxBasins[1] && $size < $maxBasins[2]) {
                $maxBasins[0] = $maxBasins[1];
                $maxBasins[1] = $size;
            } elsif($size > $maxBasins[2]) {
                $maxBasins[0] = $maxBasins[1];
                $maxBasins[1] = $maxBasins[2];
                $maxBasins[2] = $size;
            }
        }
    }
}

# Part 0 answer:
print "Number of low points in the cave: $lowCount\n";
print "Risk Rating of all the low points: $riskPoints\n";

# Part 2 answer:
print "Of the $basinCount basins, the 3 largest are \n";
print "$maxBasins[0], $maxBasins[1] and $maxBasins[2] giving a checksum of ";
print $maxBasins[0] * $maxBasins[1] * $maxBasins[2] . "\n\n";

exit(0);
#==========================================================================
sub findBasinSize {
    my ($c, $r, $len, $width, $mapRef) = @_;
    my $b = 0;

    # Base Case: edge = 9 and not part of a basin
    if($mapRef->[$c][$r] == 9) {
        return 0;
    } else {
        # Otherwise, +1 to basin size and 
        # update this position to 9 so it's not double counted later
        $b++;
        $mapRef->[$c][$r] = 9;
    }

    # Check surrounding positions starting with North
    if($c > 0) {
        $b += findBasinSize($c-1,$r,$len,$width, $mapRef);
    }

    # Check east next
    if($r < $width-1) {
        $b += findBasinSize($c,$r+1,$len,$width,$mapRef);
    }

    # Check South position
    if($c < $len-1) {
        $b += findBasinSize($c+1,$r,$len,$width,$mapRef);
    }

    # Finally check West
    if($r > 0) {
        $b += findBasinSize($c,$r-1,$len,$width,$mapRef);
    }

    return $b;
}