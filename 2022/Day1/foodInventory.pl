#!/usr/bin/perl
use warnings;
use strict;

my $currTotal = 0; # calories current elf is carrying
my $top3 = -1; # Calorie count for the top 3 elves
my @elves; # elf calorie array

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    
    my $item = $_;

    if(length($item) == 0) {
        push(@elves,$currTotal);
        $currTotal = 0;
    } else {
        $currTotal += $item;
    }
}

close(INPUT);
push(@elves,$currTotal);

@elves = sort {$b <=> $a} @elves;

# Part 1 answer:
print "There are " . scalar(@elves) . " elves on this expedition!\n";
print "The Elf carrying the most food has $elves[0] calories worth.\n";

# Part 2
$top3 = $elves[0] + $elves[1] + $elves[2];

print "The 3 Elves carrying the most calories have a total of $top3\n";

exit(0);
#==========================================================================
