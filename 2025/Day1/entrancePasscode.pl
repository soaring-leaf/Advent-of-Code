#!/usr/bin/perl
use warnings;
use strict;

my $dialPointer = 50; # Starting point of Dial
my $zeroCountPt1 = 0; # Counts times dial stops at 0
my $zeroCountPt2 = 0; # Counts times dial stops on or passes 0

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","inputTest.txt") or die "Can't open InputTest.txt $!";

while(<INPUT>) {
    chomp;
    my $direction = substr($_,0,1);
    my $clicksPt1 = substr($_,1) % 100;
    my $clicksPt2 = substr($_,1);
    my $rotatePast0Count = int($clicksPt2/100);
    
    $zeroCountPt2 += $rotatePast0Count;

    $zeroCountPt2 += doesDialPass0($dialPointer,$direction,$clicksPt2 % 100);

    $dialPointer = calcNextNumber($dialPointer,$direction,$clicksPt1);

    if($dialPointer == 0) {
        $zeroCountPt1++;
        $zeroCountPt2++;
    }
}

close(INPUT);

# Part 1 - Output Result
print "Part 1 - Times Dial stops at 0: " . $zeroCountPt1 . "\n";

# Part 2 - Output Result

print "Part 2 - Times Dial stops on or passes 0: " . $zeroCountPt2 . "\n";

exit(0);
#==========================================================================
sub calcNextNumber {
    my($dial, $dir, $count) = @_;

    if($dir eq 'L') {
        $dial -= $count;
        if($dial < 0) {
            $dial += 100;
        }
    } else {
        $dial += $count;
        if($dial > 99) {
            $dial -= 100;
        }
    }

    return $dial;
}

sub doesDialPass0 {
    my($dial, $dir, $count) = @_;

    if($dial == 0) {
        return 0; # doesn't count if it Starts at 0
    }

    if($dir eq 'L') {
        if($dial < $count) {
            return 1;
        } else {
            return 0;
        }
        
    } else {
        if($dial + $count > 100) {
            return 1;
        } else {
            return 0;
        }
    }
}