#!/usr/bin/perl
use warnings;
use strict;

my $currTotal = 0; # calories current elf is carrying
my $max = -1; # Max calorie count
my $elves = 0; # elf count

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    
    my $item = $_;

    if(length($item) == 0) {
        if($currTotal > $max) {
            $max = $currTotal;
        }
        $elves++;
        $currTotal = 0;
    } else {
        $currTotal += $item;
    }
}

close(INPUT);

if($currTotal > $max) {
    $max = $currTotal;
}
$elves++;

# Part 1 answer:
print "There are $elves elves on this expedition!\n";
print "The Elf carrying the most food has $max calories worth.\n";

# reset vars for Part 2

# Part 2: 

exit(0);
#==========================================================================
