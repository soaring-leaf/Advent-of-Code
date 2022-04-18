#!/usr/bin/perl
use warnings;
use strict;

my %marks; # locations of all the marks on the paper from input
my @instr; # instructions on where to fold the paper
my $inputGroup = 0; # flag indicating what part of input is being read - 0 for marks, 1 for instr
my $markCount = 0; # count of marks on the whole paper
my $maxX = 0; # Largest X dimension
my $maxY = 0; # Largest Y dimension

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    
    if(length($_) < 1) {
        $inputGroup++;
    } elsif($inputGroup == 0) {
        $marks{$_} = 0;
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

# First fold (Part1)
foldPaper(split('=',shift(@instr)),\%marks);

# Part 1 answer:
print "After the first Fold, there are " . scalar(keys(%marks)) . " marks showing.\n\n";

# Part 2 answer:
#print "\n\n";

exit(0);
#==========================================================================

# Folding the paper - 
    #First half of paper doesn't change coords, 
    # second half subtracts the distance to the fold value twice
sub foldPaper {
    my ($dir, $fCoord, $markHashRef) = @_;

    foreach my $m (keys %{$markHashRef}) {
        my ($x, $y) = split(',',$m);

        if($dir eq 'x' && $x > $fCoord) {
            delete($markHashRef->{$m});
            $x = $x - ($x - $fCoord) * 2;
            $markHashRef->{"$x,$y"} = 0;
        } elsif($dir eq 'y' && $y > $fCoord) {
            delete($markHashRef->{$m});
            $y = $y - ($y - $fCoord) * 2;
            $markHashRef->{"$x,$y"} = 0;
        }
    }
}