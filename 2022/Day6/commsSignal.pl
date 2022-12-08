#!/usr/bin/perl
use warnings;
use strict;

my $signal = ''; # Input signal to decipher
my $marker = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

$signal = <INPUT>;
chomp($signal);

close(INPUT);

for(my $m=0; $m < length($signal); $m++) {
    my @chars = sort {$a cmp $b} split('', substr($signal,$m,4));

    if($chars[0] ne $chars[1] && $chars[1] ne $chars[2] && $chars[2] ne $chars[3]) {
        $marker = $m + 4;
        $m = length($signal);
    }
}

print "First marker is: $marker\n";

exit(0);
#==========================================================================
