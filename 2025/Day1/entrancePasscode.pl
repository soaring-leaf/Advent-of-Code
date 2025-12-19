#!/usr/bin/perl
use warnings;
use strict;

my $dialPointerPt1 = 50; # Starting point of Dial
my $zeroCountPt1 = 0; # Counts times dial stops at 0

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    my $direction = substr($_,0,1);
    my $clicksPt1 = substr($_,1) % 100;

    $dialPointerPt1 = calcNextNumber($dialPointerPt1,$direction,$clicksPt1);

    if($dialPointerPt1 == 0) {
        $zeroCountPt1++;
    }
}

close(INPUT);

# Part 1 - Output Result
print "Part 1 - Times Dial stops at 0: " . $zeroCountPt1 . "\n";

# Part 2 - 

#print "Part 2 - " . $x . "\n";

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