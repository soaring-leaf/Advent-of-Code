#!/usr/bin/perl
use warnings;
use strict;

my $digitCount = 0; # Counter for the simple digits (Part 1)
my $outTotal = 0; # Sum of all the numbers from the output
my @display = ((0) x 7); # each index is a unit of the 7-segment display from top to bottom and left to right

## NOTES to determine segment logic for the display
# [0] - Compare 7 and 1, the extra segment in 7 goes here.
# [1] - Using 1 and 5 group to find 3 - knowing [4], the remaining missing seg goes here
# [2] - Remaining item in 6 group is 6 - missing segment goes here
# [3] - Using 1 and the 6 group, the one containing both 1 is 0 - missing segment goes here.
# [4] - Using 7, 4 and the 6 group, the one containing both 7 and 4 is 9 - missing seg goes here
# [5] - Using 1 and [2], the unassigned seg goes here
# [6] - remaining unknown segment goes here

# Order to determine segments: 0, 4, 3, 2, 5, 1, 6

my @group5; # array to hold digits of length 5
my @group6; # array to hold digits of length 6
my $one = ''; # var to hold segments for 1
my $four = ''; # segments for 4
my $seven = ''; # segments for 7
my $eight = ''; # segments for 8

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my ($input, $output) = split(' \| ');
    my @outputUnits = split(' ',$output);
    my @inputUnits = split(' ',$input);
    my $outValue = 0;

    foreach my $iUnits (@inputUnits) {
        my $len = length($iUnits);

        if($len == 5) {
            push(@group5,$iUnits);
        } elsif($len == 6) {
            push(@group6,$iUnits) 
        } else {
            if($len == 2) {
                $one = $iUnits;
            } elsif($len == 3) {
                $seven = $iUnits;
            } elsif ($len == 4) {
                $four = $iUnits;
            } else {
                $eight = $iUnits;
            }
        }
    }

    foreach my $u (@outputUnits) {
        my $len = length($u);

        if($len == 2 || $len == 3 || $len == 4 || $len == 7) {
            $digitCount++; # Part 1 counter
        }
    }

    # run segment determining logic here

    # then process the output

    $outTotal += $outValue;
}

close(INPUT);

# Part 1 answer:
print "Number of 1's, 4's, 7's and 8's in the output is $digitCount\n";

# Part 2 answer:
print "Total sum of the output is $outTotal\n\n";

exit(0);
#==========================================================================
