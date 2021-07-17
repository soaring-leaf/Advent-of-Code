#!/usr/bin/perl
use warnings;
use strict;

my @sequence = (8,5,1,12,10,0,13);
my @test = (6,3,0);
my $check = 0;
my $found = 0;

while(scalar(@test) < 10) {
    $check = $test[0];
    for(my $i=1;$i<scalar(@test);$i++) {
        if($test[$i] == $check) {
            unshift(@test,$i);
            $found++;
            $i = scalar(@test);
        }
    }

    if(!$found) {
        unshift(@test,0);
    } else {
        $found = 0;
    }

    print "Next number added is: $test[0]\n";
}

print "The 2020th number: $test[0]\n";

exit(0);
#==========================================================================
