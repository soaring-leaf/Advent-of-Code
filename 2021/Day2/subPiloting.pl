#!/usr/bin/perl
use warnings;
use strict;

my $depth = 0; # Depth position
my $horiz = 0; # Horizontal position
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
    }
}

close(INPUT);

$checkSum = $depth * $horiz;

# Part 1 answer:
print "Final position is Depth: $depth, Distance traveled: $horiz and checkSum: $checkSum.\n";

exit(0);
#==========================================================================
