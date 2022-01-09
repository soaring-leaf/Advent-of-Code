#!/usr/bin/perl
use warnings;
use strict;

my @numDraw; # Array to hold the numbers in the order drawn
my @boards; # Array to hold each Hash-board
my $bestBoard = -1; # Number of the winning board
my $bestScore = 0; # Score of the best board
my $currScore = 0; # Score of the current board to be calculated

my %hashTest = ('a')

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

@numDraw = split(',',chomp(<INPUT>));

# build the boards
while(<INPUT>) {
    chomp;

    my $sum = 0; # sum for the rows

    # Init a boardHash with a .. j = 0
            # where a .. e is the number of row hits (top to bottom)
            # f .. j = num of col hits (left to right)
            # s? = sum of each row where ? = row number
    my %currBoard = ('a',0,'b',0,'c',0,'d',0,'e',0,'f',0,'g',0,'h',0,'i',0,'j',0); 

    for(my $row=0;$row<5;$row++) {
        my @newRow = split(' ',chomp(<INPUT>));

        for (my $i=0;$i<scalar(@newRow);$i++) {
            $sum += $newRow[i];
            $currBoard{$newRow[i]} = $row . ',' . $i;
        }

        $currBoard{('s'.$row)} = $sum;

        $sum = 0;
    }

    push(@boards,\%currBoard)
}

close(INPUT);

# evaluate each board one at a time until it wins or runs out of drawn numbers
# for each draw: 
    # add one to the applicable a .. j Key count
    # subtract the drawn number from the applicable row sum
# after 5 draws and each after, check for a winner 
# score the board and update the best board info if applicable

# Part 1 answer:
print "Best board is $bestBoard, with a score of $bestScore.\n\n";

# Part 2 answer:
#print "\n";

exit(0);
#==========================================================================
# Input is a Bingo Board (Hash)
sub checkForWinner {
    # Run through a .. j keys to see if any = 5 (every number in row/col is hit)
}

# gets the total sum of the numbers not hit from a winning board
sub getBoardSum {
    # run through s0 .. s4 to add up the unmarked numbers
    # return the total
}