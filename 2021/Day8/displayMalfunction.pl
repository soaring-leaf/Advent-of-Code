#!/usr/bin/perl
use warnings;
use strict;

my $digitCount = 0; # Counter for the simple digits (Part 1)
my $outTotal = 0; # Sum of all the numbers from the output
my @display; # each index is a unit of the 7-segment display from top to bottom and left to right

# Order to determine segments: 0, 4, 3, 2, 5, 1, 6

## NOTES to determine segment logic for the display
# [0] - Compare 7 and 1, the extra segment in 7 goes here.
# [1] - Using 1 and 5 group to find 3 - knowing [4], the remaining missing seg goes here
# [2] - Remaining item in 6 group is 6 - missing segment goes here
# [3] - Using 1 and the 6 group, the one containing 1 is 0 - missing segment goes here.
# [4] - Using 7, 4 and the 6 group, the one containing both 7 and 4 is 9 - missing seg goes here
# [5] - Using 1 and [2], the unassigned seg goes here
# [6] - remaining unknown segment goes here

my @group5; # array to hold digits of length 5
my @group6; # array to hold digits of length 6
my $one = ''; # var to hold segments for 1
my $four = ''; # segments for 4
my $seven = ''; # segments for 7
my $eight = ''; # segments for 8
my $tempRef = ''; # temp var for getting returned array ref

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my ($input, $output) = split(' \| ');
    my @outputUnits = split(' ',$output);
    my @inputUnits = split(' ',$input);

    foreach my $iUnits (@inputUnits) {
        my $len = length($iUnits);

        if($len == 5) {
            push(@group5,$iUnits);
        } elsif($len == 6) {
            push(@group6,$iUnits) 
        } else {
            if($len == 2) {
                $one = $iUnits;
            } elsif($len == 3) {
                $seven = $iUnits;
            } elsif ($len == 4) {
                $four = $iUnits;
            } else {
                $eight = $iUnits;
            }
        }
    }

    foreach my $u (@outputUnits) {
        my $len = length($u);

        if($len == 2 || $len == 3 || $len == 4 || $len == 7) {
            $digitCount++; # Part 1 counter
        }
    }

    # run segment determining logic here
    $display[0] = getSeg0($one,$seven);
    ($display[4], $tempRef) = getSeg4($seven,$four,\@group6);
    ($display[3], $tempRef) = getSeg3($one,$tempRef);
    $display[2] = getSeg2($tempRef);
    $display[5] = getSeg5($one,$display[2]);
    $display[1] = getSeg1($one,$display[4],\@group5);
    $display[6] = getSeg6(\@display);
    
    # then process the output

    #$outTotal += first * 1000;
    #$outTotal += second * 100;
    #$outTotal += third * 10;
    #$outTotal += fourth;
}

close(INPUT);

# Part 1 answer:
print "Number of 1's, 4's, 7's and 8's in the output is $digitCount\n";

# Part 2 answer:
print "Total sum of the output is $outTotal\n\n";

exit(0);
#==========================================================================
sub getSeg0 {
    my ($o, $s) = @_;

    for(my $c=0; $c < 3; $c++) {
        my $seg = substr($s,$c,1);
        if(index($o,$seg) == -1) {
            return $seg;
        }
    }
}

sub getSeg1 {
    my ($o1,$o2) = split('',$_[0]);
    my $s4 = $_[1];
    my @g5 = @{$_[2]};
    my $three = '';
    my @segCheck = ('a' .. 'g');

    foreach my $num (@g5) {
        if(index($num,$o1) >= 0 && index($num,$o2) >= 0) {
            $three = $num;
        }
    }

    foreach $seg (@segCheck) {
        if(index($three,$seg) == -1 && $seg != $s4) {
            return $seg;
        }
    }
}

sub getSeg2 {
    my $six = $_[0] -> [0];
    my @segCheck = ('a' .. 'g');

    foreach $seg (@segCheck) {
        if(index($six,$seg) == -1) {
            return $seg;
        }
    }
}

sub getSeg3 {
    my ($o1,$o2) = split('',$_[0]);
    my @g6 = @{$_[1]};
    my $zero = '';
    my @segCheck = ('a' .. 'g');

    if(index($g6[0],$o1) >= 0 && index($g6[0],$o2) >= 0)) {
        $zero = shift(@g6);
    } else {
        $zero = pop(@g6);
    }

    foreach $seg (@segCheck) {
        if(index($zero,$seg) == -1) {
            return ($seg,\@g6);
        }
    }
}

sub getSeg4 {
    my $s = $_[0];
    my $f = $_[1];
    my @g6 = @{$_[2]};

    pop(@g6);

    return ('a',\@g6);
}

sub getSeg5 {
    my ($o1,$o2) = split('',$_[0]);
    my $s2 = $_[1];

    if($s2 == $o1) {
        return $o2;
    } else {
        return $o1;
    }
}

sub getSeg6 {
    my $d = join(@{$_[0]});
    my @segCheck = ('a' .. 'g');

    foreach $seg (@segCheck) {
        if(index($d,$seg) == -1) {
            return $seg;
        }
    }
}