#!/usr/bin/perl
use warnings;
use strict;

my %caveConnections; # List of all the passages between rooms in cave
my %roomSize; # List of the rooms and if they are Big (1) or little (0)
my $pathCount = 0; # count of viable paths

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my ($first, $second) = split('-',$_);

    if($first eq uc($first)) {
        $roomSize{$first} = 1;
    } else {
        $roomSize{$first} = 0;
    }
    
    if($second eq uc($second)) {
        $roomSize{$second} = 1;
    } else {
        $roomSize{$second} = 0;
    }

    # Start is one way out, no need to build paths FROM End
    
    # if first time seeing room, create array and add to hash for path
    # otherwise, add the room to the array
    if($first ne 'end' && $second ne 'start') {
        if(!exists($caveConnections{$first})) {
            my @newPath = ($second);
            $caveConnections{$first} = \@newPath;
        } else { 
            push(@{$caveConnections{$first}},$second);
        }
    }

    # do for both directions
    if($first ne 'start' && $second ne 'end') {
        if(!exists($caveConnections{$second})) {
            my @otherPath = ($first);
            $caveConnections{$second} = \@otherPath;
        } else {
            push(@{$caveConnections{$second}},$first);
        }
    }
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
