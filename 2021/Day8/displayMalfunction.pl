#!/usr/bin/perl
use warnings;
use strict;

my $digitCount = 0; # Counter for the simple digits (Part 1)
my $outTotal = 0; # Sum of all the numbers from the output

# Order to determine segments: 0, 4, 3, 2, 5, 1, 6

## NOTES to determine segment logic for the display
# [0] - Compare 7 and 1, the extra segment in 7 goes here.
# [1] - Using 1, [4] and 5 group, find 3 - knowing [4], the remaining missing seg goes here
# [2] - Remaining item in 6 group is 6 - missing segment goes here
# [3] - Using 1 and the 6 group, the one containing 1 is 0 - missing seg goes here.
# [4] - Using 4 and the 6 group, the one containing 4 is 9 - missing seg goes here
# [5] - Using 1 and [2], the unassigned seg goes here
# [6] - remaining unknown segment goes here

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    my @display; # each index is a unit of the 7-segment display from top to bottom and left to right
    my @group5; # array to hold digits of length 5
    my @group6; # array to hold digits of length 6
    my $one = ''; # var to hold segments for 1
    my $four = ''; # segments for 4
    my $seven = ''; # segments for 7
    my $eight = ''; # segments for 8
    my $tempRef = ''; # temp var for getting returned array ref

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
    ($display[4], $tempRef) = getSeg4($four,\@group6);
    ($display[3], $tempRef) = getSeg3($one,$tempRef);
    $display[2] = getSeg2($tempRef);
    $display[5] = getSeg5($one,$display[2]);
    $display[1] = getSeg1($one,$display[4],\@group5);
    $display[6] = getSeg6(\@display);
    
    # then process the output

    $outTotal += getOutputDigit($outputUnits[0],\@display) * 1000;
    $outTotal += getOutputDigit($outputUnits[1],\@display) * 100;
    $outTotal += getOutputDigit($outputUnits[2],\@display) * 10;
    $outTotal += getOutputDigit($outputUnits[3],\@display);

    @display = '';
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

    foreach my $seg (@segCheck) {
        if(index($three,$seg) == -1 && $seg ne $s4) {
            return $seg;
        }
    }
}

sub getSeg2 {
    my $six = $_[0] -> [0];
    my @segCheck = ('a' .. 'g');

    foreach my $seg (@segCheck) {
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

    if(index($g6[0],$o1) >= 0 && index($g6[0],$o2) >= 0) {
        $zero = shift(@g6);
    } else {
        $zero = pop(@g6);
    }

    foreach my $seg (@segCheck) {
        if(index($zero,$seg) == -1) {
            return ($seg,\@g6);
        }
    }
}

sub getSeg4 {
    my ($f1,$f2,$f3,$f4) = split('',$_[0]);
    my @g6 = @{$_[1]};
    my $nine = '';
    my @segCheck = ('a' .. 'g');

    while($nine eq '') {
        my $temp = shift(@g6);

        if(index($temp,$f1) >= 0 && index($temp,$f2) >= 0 && index($temp,$f3) >= 0 && index($temp,$f4) >= 0) {
            $nine = $temp;
        } else {
            push(@g6,$temp);
        }
    }

    foreach my $seg (@segCheck) {
        if(index($nine,$seg) == -1) {
            return ($seg,\@g6);
        }
    }
}

sub getSeg5 {
    my ($o1,$o2) = split('',$_[0]);
    my $s2 = $_[1];

    if($s2 eq $o1) {
        return $o2;
    } else {
        return $o1;
    }
}

sub getSeg6 {
    my $d = join('',@{$_[0]});
    
    my @segCheck = ('a' .. 'g');

    foreach my $seg (@segCheck) {
        if(index($d,$seg) == -1) {
            return $seg;
        }
    }
}

sub getOutputDigit {
    my $digit = $_[0];
    my $len = length($digit);

    if($len == 2) {
        return 1;
    } elsif($len == 3) {
        return 7;
    } elsif ($len == 4) {
        return 4;
    } elsif ($len == 7) {
        return 8;
    }

    my $dsp = $_[1];

    if($len == 5) {
        if(index($digit,$dsp->[1]) == -1 && index($digit,$dsp->[5]) == -1) {
            return 2;
        } elsif(index($digit,$dsp->[1]) == -1 && index($digit,$dsp->[4]) == -1) {
            return 3;
        } else {
            return 5;
        }

    } else { # length = 6
        if(index($digit,$dsp->[3]) == -1) {
            return 0;
        } elsif(index($digit,$dsp->[2]) == -1) {
            return 6;
        } else {
            return 9;
        }
    }
}