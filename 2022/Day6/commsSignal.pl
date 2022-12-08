#!/usr/bin/perl
use warnings;
use strict;

my $signal = ''; # Input signal to decipher
my $pktMarker = 0;
my $msgMarker = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

$signal = <INPUT>;
chomp($signal);

close(INPUT);

for(my $p=0; $p < length($signal); $p++) {
    my @chars = sort {$a cmp $b} split('', substr($signal,$p,4));

    if($chars[0] ne $chars[1] && $chars[1] ne $chars[2] && $chars[2] ne $chars[3]) {
        $pktMarker = $p + 4;
        $p = length($signal);
    }
}

print "First packet marker is: $pktMarker\n";

# Part 2 - Find the Start of Message marker

for(my $m=0; $m < length($signal); $m++) {
    my @chars = sort {$a cmp $b} split('', substr($signal,$m,14));
    my $found = 1;

    for(my $i=0; $i < 13; $i++) {
        if($chars[$i] eq $chars[$i+1]) {
            $found = 0;
            $i = 14;
        }
    }

    if($found == 1) {
        $msgMarker = $m + 14;
        $m = length($signal);
    }
    
}

print "First message marker is: $msgMarker\n\n";

exit(0);
#==========================================================================
