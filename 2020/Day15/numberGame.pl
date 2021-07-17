#!/usr/bin/perl
use warnings;
use strict;

my @sequence = (8,5,1,12,10,0,13);
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

    $turn++;

    if($turn % 500000 == 0) {
        print "On Turn $turn\n";
    }

    #print "Next number added is: $test[0]\n";
}

print "The 2020th number: $sequence[0]\n";

exit(0);
#==========================================================================
