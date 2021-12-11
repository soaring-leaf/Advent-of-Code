#!/usr/bin/perl
use warnings;
use strict;

my $count = 0; # Diagnostic report row count
my @bitValues; # Array to hold each bit of the current diagnostic value
my $gammaBitValue = '';
my $epsilonBitValue = '';
my $gamma = 0; # Decimal value of the Gamma Rate
my $epsilon = 0; # Decimal value of the Epsilon Rate
my $powerConsumption = 0; # once calculated, the Gamma Rate * Epsilon Rate

# Initialize hash to find most common bit value in each position
# each key is the bit position (reading Left to Right)
my %bitPosCounterForValue1 = (
        0 => 0,
        1 => 0,
        2 => 0,
        3 => 0,
        4 => 0,
        5 => 0,
        6 => 0,
        7 => 0,
        8 => 0,
        9 => 0,
        10 => 0,
        11 => 0
    );


open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    $count++;

    chomp;
    @bitValues = split('');

    for(my $i=0;$i<scalar(@bitValues);$i++) {
        if($bitValues[$i] eq '1') {
            $bitPosCounterForValue1{$i}++;
        } else {
            $bitPosCounterForValue1{$i}--;
        }
    }
}

close(INPUT);

# build the Binary Gamma and Epsilon values
for(my $k=0;$k<12;$k++) {
    if($bitPosCounterForValue1{$k} > 0) {
        $gammaBitValue = $gammaBitValue . '1';
        $epsilonBitValue = $epsilonBitValue . '0';
    } else {
        $gammaBitValue = $gammaBitValue . '0';
        $epsilonBitValue = $epsilonBitValue . '1';
    }
}

$gamma = oct("0b".$gammaBitValue);
$epsilon = oct("0b".$epsilonBitValue);

$powerConsumption = $gamma * $epsilon;

# Part 1 answer:
print "Rate values - Gamma: $gamma, Epsilon: $epsilon and Power Consumption: $powerConsumption.\n\n";


# Part 2 ???:

exit(0);
#==========================================================================
