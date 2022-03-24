#!/usr/bin/perl
use warnings;
use strict;

my @fishBuckets = ((0) x 9); # Buckets for the fish in each day
my $total80 = 0; # Final count of fish after 80 days
my $total256 = 0; # Final count after 256 days

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

# Part 1: 1 - 80 days
for(my $p1 = 0; $p1 < 80; $p1++) {
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

# Part 2: Day 81 - 256
# continue doing the same thing up to day 256
for(my $p2 = 80; $p2 < 256; $p2++) {
    my $temp = $fishBuckets[0];

    for(my $f2=0; $f2 < scalar(@fishBuckets) - 1; $f2++) {
        $fishBuckets[$f2] = $fishBuckets[$f2+1];
    }

    $fishBuckets[6] += $temp;
    $fishBuckets[8] = $temp;
}

foreach my $b2 (@fishBuckets) {
    $total256 += $b2;
}

# Part 1 answer:
print "Total fish after 256 days is: $total80\n";

# Part 2 answer:
print "Total fish after 80 days is: $total256\n\n";

exit(0);
#==========================================================================
