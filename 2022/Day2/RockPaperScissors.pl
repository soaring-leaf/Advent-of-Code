#!/usr/bin/perl
use warnings;
use strict;

# A = R, B = P, C = S
# X = R, Y = P, Z = S
my %win = ('X' => 'C', 'Y' => 'A', 'Z' => 'B');
my %draw = ('X' => 'A', 'Y' => 'B', 'Z' => 'C');
my %loss = ('X' => 'B', 'Y' => 'C', 'Z' => 'A');
my %throw = ('X' => 1, 'Y' => 2, 'Z' => 3);
my $score = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    my ($p1, $p2) = split(' ');

    if($win{$p2} eq $p1) {
        $score += 6;
    } elsif($draw{$p2} eq $p1) {
        $score += 3;
    }

    $score += $throw{$p2};
}

close(INPUT);

# Part 1:

print "Score following the plan would be $score\n";

# Part 2:

#print "\n\n";

exit(0);
#==========================================================================
