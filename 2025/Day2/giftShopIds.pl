#!/usr/bin/perl
use warnings;
use strict;

my @ranges; # Array of all the ranges
my $invalidSum = 0; # Running Total of the Invalid IDs

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    @ranges = split(',',$_);
}

close(INPUT);

foreach(@ranges) {
    my ($start,$end) = split('-',$_);
    
    my $len = length($start);
    if(!($len == length($end) && $len % 2 == 1)) {
        $invalidSum += findInvalidIds($start, $end);
    }
}

# Part 1 - Output Result
print "Part 1 - Sum of all invalid IDs: $invalidSum\n";

# Part 2 - Output Result

#print "Part 2 -  " . $x . "\n";

exit(0);
#==========================================================================
sub findInvalidIds {
    my($first, $last) = @_;
    my $sum = 0;
    my $lengthToGet;
    my $counter = 0;

    if(length($first) % 2 == 0) {
        $lengthToGet = length($first)/2;
        $counter = substr($first,0,$lengthToGet);
    } else {
         $lengthToGet = (length($last)/2) - 1;
         $counter = 10 ** $lengthToGet;
    }

    my $firstNum = $counter . $counter;

    if($firstNum < $first) {
        $counter++;
        $firstNum = $counter . $counter;
    }

    my $num = $firstNum;

    while($num <= $last) {
        $sum += $num;

        $counter++;
        $num = $counter . $counter;
    }
    
    return $sum;
}