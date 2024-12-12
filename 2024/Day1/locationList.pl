#!/usr/bin/perl
use warnings;
use strict;

my @leftList; # List of numbers from the left side of the input
my @rightList; # List of numbers from the right side of the input
my $compareSum = 0; # Summation of the distances between the numbers in the list
my %numCounter; # Hash of {Number, times it's in the List} for the Right List
my $similarityScore = 0; # Similarity Score total

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    my ($left, $right) = split(' ',$_);

    push(@leftList,$left);
    push(@rightList,$right);

    if(exists $numCounter{$right}) {
        $numCounter{$right} += 1;
    } else {
        $numCounter{$right} = 1;
    }
}

close(INPUT);

@leftList = sort { $a cmp $b } @leftList;
@rightList = sort { $a cmp $b } @rightList;

# Part 1 Calc -
for(my $i = 0; $i < scalar(@leftList); $i++) {
    $compareSum += abs($leftList[$i] - $rightList[$i]);
}

print "Part 1 - Distance Total between the Lists: " . $compareSum . "\n";

# Part 2 - 

for(my $i = 0; $i < scalar(@leftList); $i++) {
    my $multiplier = 0;

    if(exists $numCounter{$leftList[$i]}) {
        $multiplier = $numCounter{$leftList[$i]};
    }

    $similarityScore += $leftList[$i] * $multiplier;
}

print "Part 2 - List Similarity Score: " . $similarityScore . "\n";

exit(0);
#==========================================================================
