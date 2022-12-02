#!/usr/bin/perl
use warnings;
use strict;

# A = R, B = P, C = S
# X = R, Y = P, Z = S
my %win = ('X' => 'C', 'Y' => 'A', 'Z' => 'B');
my %draw = ('X' => 'A', 'Y' => 'B', 'Z' => 'C');
my %loss = ('X' => 'B', 'Y' => 'C', 'Z' => 'A');
my %winPt2 = ('A' => 'Y', 'B' => 'Z', 'C' => 'X');
my %drawPt2 = ('A' => 'X', 'B' => 'Y', 'C' => 'Z');
my %lossPt2 = ('A' => 'Z', 'B' => 'X', 'C' => 'Y');
my %throw = ('X' => 1, 'Y' => 2, 'Z' => 3);
my $score1 = 0; # Score for Part1
my $score2 = 0; # Score for Part2

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    my ($p1, $p2) = split(' ');

    # Part 1

    if($win{$p2} eq $p1) {
        $score1 += 6;
    } elsif($draw{$p2} eq $p1) {
        $score1 += 3;
    }

    $score1 += $throw{$p2};

    # Part 2
    if($p2 eq 'Z') {
        $score2 += 6 + $throw{$winPt2{$p1}};
    } elsif($p2 eq 'Y') {
        $score2 += 3 + $throw{$drawPt2{$p1}};
    } else {
        $score2 += $throw{$lossPt2{$p1}};
    }
}

close(INPUT);

print "Score following the plan would be $score1\n";

print "Score following the actual plan would be $score2\n\n";

exit(0);
#==========================================================================
