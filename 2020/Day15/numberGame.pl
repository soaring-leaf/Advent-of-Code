#!/usr/bin/perl
use warnings;
use strict;

my @sequence = (8,5,1,12,10,0,13); # push newest number on front of array
my @test = (6,3,0);
my $check = 0;
my $found = 0;
my $turn = 7;

while(scalar(@sequence) < 2020) {
    $check = $sequence[0];
    for(my $i=1;$i<scalar(@sequence);$i++) {
        if($sequence[$i] == $check) {
            unshift(@sequence,$i);
            $found++;
            $i = scalar(@sequence);
        }
    }

    if(!$found) {
        unshift(@sequence,0);
    } else {
        $found = 0;
    }

    #print "Next number added is: $test[0]\n";
}

print "The 2020th number: $sequence[0]\n";

# =================================================================
# Part 2 - Part 1 is not efficient enough for 30,000,000 iterations
# =================================================================

my %numMap = (); # need hash for faster lookup

# reset vars
@sequence = (13,0,10,12,1,5,8); # order is now Left to Right
@test = (0,3,6);
$check = 0;
$turn = 0;

# Init turnMap with starting numbers
for(my $i=0;$i<scalar(@sequence);$i++) {
    my @turnTracker = ($turn);
    $check = $sequence[$i];
    $numMap{$check} = \@turnTracker;
    $turn++;
}

# next turn is known to be zero so put it in for easier coding later
$check = 0;
push(@{$numMap{$check}},$turn); 
$turn++;

# print "confirm pushing turn to array in hash works [0,1]:\n";
# print $numMap{$check}[0] . "\n";
# print $numMap{$check}[1] . "\n";
# confirmed above is working as expected!

while ($turn < 30000000) {

    # 'time' check
#    if($turn % 500000 == 0) {
#        print "turn: $turn: number from last turn = $check\n";
#    }

    # last number said from previous turn must exist
    # if last number exists but only has one entry, it's only been said once
        # next number = 0
    if(@{$numMap{$check}} == 1) {
        # update 0 in the hashMap, it already has two entries
        $check = 0;
        $numMap{$check}[0] = $numMap{$check}[1];
        $numMap{$check}[1] = $turn;
    } else {
        # if last number has more than 1 entry
        # calc next number to be said
        $check = $numMap{$check}[1] - $numMap{$check}[0];
        # if !exists in hash, add new entry for next number
        # if new number exists in hash, then need to update the hash for that num
        if(!exists($numMap{$check})) {
            my @newTracker = ($turn);
            $numMap{$check} = \@newTracker;
        } elsif(@{$numMap{$check}} == 1) {
            # if this is the second occurrence, need to push current turn into array
            push(@{$numMap{$check}},$turn);
        } else {
            # else update values: move [0] to [1] and update [0] with new value
            $numMap{$check}[0] = $numMap{$check}[1];
            $numMap{$check}[1] = $turn;
        }
    }
    $turn++;
}

print "Number for turn $turn is $check \n";

exit(0);
#==========================================================================
