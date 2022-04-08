#!/usr/bin/perl
use warnings;
use strict;

my %caveConnections; # List of all the passages between rooms in cave
my $pathCount = 0; # count of viable paths

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my ($first, $second) = split('-',$_);
    
    # if first time seeing room, create array and add to hash for path
    # else add path to hash array
    # do for both directions unless Start/End is present
}

close(INPUT);

# figure out how to traverse the cave starting with 'start'
# need way to determine if little cave has already been visited
# if successful in reaching end, +1 to pathCount

# Part 1 answer:
print "There are $pathCount paths through the cave.\n\n";

# Part 2 answer:
print "\n\n";

exit(0);
#==========================================================================
