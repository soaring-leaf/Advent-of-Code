#!/usr/bin/perl
use warnings;
use strict;

my $curr = 0; # input currently being read
my $prev = -1; # The previous number
my $totalInc = 0; # Total times the depth increases


open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    if($prev != -1 && $prev < $_) {
        $totalInc++;
    }
    $prev = $_;
}

close(INPUT);

# Part 1 answer:
print "Scanner found the depth increases $totalInc times.\n";

# Part 2: Use built hashes to figure out which field is which

exit(0);
#==========================================================================
