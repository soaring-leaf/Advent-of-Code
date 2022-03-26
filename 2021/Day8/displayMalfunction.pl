#!/usr/bin/perl
use warnings;
use strict;

my $digitCount = 0; # Counter for the simple digits (Part 1)

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my ($input, $output) = split(' \| ');

    my @outputUnits = split(' ',$output);

    foreach my $u (@outputUnits) {
        my $len = length($u);
        if($len == 2 || $len == 3 || $len == 4 || $len == 7) {
            $digitCount++;
        }
    }
}

close(INPUT);

# Part 1 answer:
print "Number of 1's, 4's, 7's and 8's in the output is $digitCount\n";

# Part 2 answer:
#print "\n\n";

exit(0);
#==========================================================================
