#!/usr/bin/perl
use warnings;
use strict;

my $section = 0; # Section of input currently being read
my $err = 0; # Tracks Ticket Error Rate of invalid numbers
my $max = 0; # Max valid number
my $min = -1; # Min valid number - ranges overlap so only need one max/min set

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    if(length($_) < 5) {
        $section++;
    } elsif ($section == 0) {
        my ($label,$ranges) = split(': ');
        my ($currMin,$junk,$currMax) = split('-',$ranges);

        if($min == -1 || $min > $currMin) {
            $min = $currMin;
        }
        
        if ($max < $currMax) {
            $max = $currMax;
        }
    } elsif($section == 1) {
        # Part 1 - ignore my ticket so nothing to do here
    } else {
        my @currTicket = split(',');

        if(scalar(@currTicket) > 1) {
            for (my $i=0;$i<scalar(@currTicket);$i++) {
                if($currTicket[$i] < $min || $currTicket[$i] > $max) {
                    $err += $currTicket[$i];
                }
            }
        }
    }
}

close(INPUT);

print "Ticket scanning Error Rate is $err \n";

exit(0);
#==========================================================================
