#!/usr/bin/perl
use warnings;
use strict;

my $depth = 0; # Depth position for Part 1 and Aim for Part 2
my $horiz = 0; # Horizontal position - Part 1 and Part 2 (Same calc)
my $depth2 = 0; # Depth position - Part 2
my @command; # Array to hold the current input command
my $checkSum = 0; # depth * horiz to verify final position

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    @command = split(' ');

    if($command[0] eq 'down') {
        $depth += $command[1];
    } elsif($command[0] eq 'up') {
        $depth -= $command[1];
    } else {
        $horiz += $command[1];

        # Part 2 calc uses the Part 1 depth for the aim since they would be the same
        # Only need to calculate the new depth since the Horizontal Position is the same calc
        if($depth != 0) {
            $depth2 += $command[1] * $depth;
        }
    }
}

close(INPUT);

$checkSum = $depth * $horiz;

# Part 1 answer:
print "Final position is Depth: $depth, Distance traveled: $horiz and checkSum: $checkSum.\n\n";

$checkSum = $depth2 * $horiz;

# Part 2 answer:
print "True final position is Depth: $depth2, Distance traveled: $horiz and checkSum: $checkSum.\n";

exit(0);
#==========================================================================
