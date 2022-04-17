#!/usr/bin/perl
use warnings;
use strict;

my @marks; # locations of all the marks on the paper from input
my @instr; # instructions on where to fold the paper
my $inputGroup = 0; # flag indicating what part of input is being read - 0 for marks, 1 for instr
my $markCount = 0; # count of marks on the whole paper
my $marksShowing = 0; # count of marks showing after the first fold
my $maxX = 0; # Largest X dimension
my $maxY = 0; # Largest Y dimension

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    
    if(length($_) < 3) {
        $inputGroup++;
    } elsif($inputGroup == 0) {
        push(@marks,$_);
        $markCount++;

        # find largest x and y coords
        my ($x, $y) = split(',',$_);

        if($x > $maxX) {
            $maxX = $x;
        }

        if($y > $maxY) {
            $maxY = $y;
        }
    } else {
        push(@instr,substr($_,11));
    }
}

close(INPUT);

# Important stats and details to know about the input
print "There are $markCount marks. \n";
print "Width of paper (x): $maxX\n";
print "Height of paper (y): $maxY\n";
print "Additionally, there are " . scalar(@instr) . " fold instructions.\n\n";

# Part 1 answer:
print "After the first Fold, there are $marksShowing marks showing.\n\n";

# Part 2 answer:
#print "\n\n";

exit(0);
#==========================================================================
