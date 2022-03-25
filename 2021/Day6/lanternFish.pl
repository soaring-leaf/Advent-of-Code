#!/usr/bin/perl
use warnings;
use strict;

my @fishBuckets = ((0) x 9); # Buckets for the fish in each day
my $total80 = 0; # Final count of fish after 80 days
my $total256 = 0; # Final count after 256 days

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

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
# Part 2: Day 81 - 256
for(my $p = 0; $p < 256; $p++) {
    my $temp = $fishBuckets[0];

    # process a day in the lanternfish life
    for(my $f=0; $f < scalar(@fishBuckets) - 1; $f++) {
        $fishBuckets[$f] = $fishBuckets[$f+1];
    }

    $fishBuckets[6] += $temp; # 0-day lanternfish reset to a 6-clock
    $fishBuckets[8] = $temp; # 0-day lanternfish spawn a new lanternfish with an 8-clock

    # calculate fish count after 80 days for Pt 1
    if($p == 79) {
        $total80 = countFish(\@fishBuckets);
    }
}

$total256 = countFish(\@fishBuckets);

# Part 1 answer:
print "Total fish after 80 days is: $total80\n";

# Part 2 answer:
print "Total fish after 256 days is: $total256\n\n";

exit(0);
#==========================================================================
sub countFish {
    my @currArray = @{$_[0]};
    my $total = 0;
    
    foreach my $f (@currArray) {
        $total += $f;
    }

    return $total;
}