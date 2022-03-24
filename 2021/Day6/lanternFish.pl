#!/usr/bin/perl
use warnings;
use strict;

my @fishBuckets = ((0) x 9); # Buckets for the fish in each day
my $total80 = 0; # Final count of fish

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Inptu file $!";

while(<INPUT>) {
    chomp;
    my @fish = split(',');

    # input is each fish represented by the day it's at
    # just need to put it in the indicated bucket
    foreach my $e (@fish) {
        $fishBuckets[$e]++;
    }
}

close(INPUT);

for(my $d = 0; $d < 80; $d++) {
    my $temp = $fishBuckets[0];

    # process a day in the lanternfish life
    for(my $f=0; $f < scalar(@fishBuckets) - 1; $f++) {
        $fishBuckets[$f] = $fishBuckets[$f+1];
    }

    $fishBuckets[6] += $temp; # 0-day lanternfish reset to a 6-clock
    $fishBuckets[8] = $temp; # 0-day lanternfish spawn a new lanternfish with an 8-clock
}

# find the total current fish after 80 days
foreach my $b (@fishBuckets) {
    $total80 += $b;
}

# Part 1 answer:
print "Total fish after 80 days is: $total80\n";

# Part 2 answer:
#print "\n\n";

exit(0);
#==========================================================================
