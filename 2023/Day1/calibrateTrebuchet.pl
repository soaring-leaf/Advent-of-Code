#!/usr/bin/perl
use warnings;
use strict;

my $calibrationSum = 0; # Sum of all the Calibration Lines

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    my $currLine = $_;

    $currLine =~ s/\D//g;
    
    $calibrationSum += (substr($currLine,0,1) * 10) + substr($currLine,-1);
}

close(INPUT);

print "Calibration Total: " . $calibrationSum . "\n";

# Part 2 - 

exit(0);
#==========================================================================

