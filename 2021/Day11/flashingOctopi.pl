#!/usr/bin/perl
use warnings;
use strict;

my $flashCount = 0; # Count of flashes
my @octopiGrid; # main grid of the energy level for each octopus
my @octoCalcGrid; # grid used to calculate the next step

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my @line = split('',$_);
    
    push(@octopiGrid,\@line);    
}

close(INPUT);

for(my $s=0; $s < 100; $s++) {
    advanceStep(\@octopiGrid);
    $flashCount += countFlashes(\@octopiGrid);
}

# Part 1 answer:
print "After 100 steps, there were $flashCount flashes.\n\n";

# Part 2 answer:
print "\n\n";

exit(0);
#==========================================================================
# Takes OctopiGrid and updates each octopus with +1 energy
sub advanceStep {
    my @grid = @{$_[0]};

    for(my $c=0; $c < 10; $c++) {
        for(my $r=0; $r < 10; $r++) {
            $grid[$c][$r]++;
        }
    }
}

# Takes OctopiGrid and processes the flashes
sub countFlashes {
    my $count = 0;
    my @grid = @{$_[0]};

    # for each grid position, if octo is 10+, update the surrounding octos
    # BUT not if the adjacent octo is at 0 and flag if a flash is detected
    # run through again and update any flashed octos to 0
    # if flagged, run through above again.

    # return total number of flashes for this entire step

    return $count;
}