#!/usr/bin/perl
use warnings;
use strict;

my $count = 0; # Diagnostic report row count
my @diagnosticRpt; # 2-D array holding each row of the report
my $gammaBitValue = '';
my $epsilonBitValue = '';
my $gamma = 0; # Decimal value of the Gamma Rate
my $epsilon = 0; # Decimal value of the Epsilon Rate
my $O2GenRating = 0; # Decimal value for the O2 Generator Rating
my $CO2ScrubberRating = 0; # Decimal value for the CO2 Scrubber rating
my $powerConsumption = 0; # once calculated, the Gamma Rate * Epsilon Rate
my $lifeSupportRating = 0; # once calculated, the O2GenRating * CO2ScrubberRating

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
    my @bitValues = split('');

    push(@diagnosticRpt,\@bitValues);

    for(my $i=0;$i<scalar(@bitValues);$i++) {
        if($bitValues[$i] eq '1') {
            $bitPosCounterForValue1{$i}++;
        } else {
            $bitPosCounterForValue1{$i}--;
        }
    }
}

close(INPUT);

print "Bit Counter values:\n";

# build the Binary Gamma and Epsilon values
for(my $k=0;$k<12;$k++) {
    print "Position $k: $bitPosCounterForValue1{$k}\n";

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
print "Power values - Gamma: $gamma, Epsilon: $epsilon and Power Consumption: $powerConsumption.\n\n";


# Part 2 - Find the O2 Generator and CO2 Scrubber ratings
my @O2BestMatch = 0; # Value of the best matching Diagnostic Line for the O2 Generator
my @CO2BestMatch = 0; # same for the CO2 Scrubber
my $currO2Count = 0; # current match value for the O2 Generator
my $currCO2Count = 0; # same for the CO2 Scrubber
my $O2Max = 0; # largest number of bit matches for the O2 count
my $CO2Max = 0; # same for CO2 count
my $deviceFlag = 0; # Flag indicating match for O2 (0) or CO2 (1) when analyzing Diagnostic row

# Run through each Diagnostic row output and determine the best match count for each device
for(my $m=0;$m<scalar(@diagnosticRpt);$m++) {
    my @diagnosticVal = @{$diagnosticRpt[$m]};

    # gammaBitValue indicates the most common Bit value for that positon => O2 Generator
    # epsilonBitValue indicates least common Bit values => CO2 Scrubber
    if($diagnosticVal[0] == substr($gammaBitValue,0,1)) {
        $deviceFlag = 0; 
        $currO2Count++;
    } else {
        $deviceFlag = 1;
        $currCO2Count++;
    }

    for(my $n=1;$n<scalar(@diagnosticVal);$n++) {
        # check each bit for the given device
        # if it fails the bitCheck for the expected value, stop the analysis
    }

    # check for improved match against current best match of the current device
    
    # reset values for next round of checks
    $currO2Count = 0;
    $currCO2Count = 0;
}

# pull the Binary values of the ratings and convert to Decimal and then calc the Life Support rating

$lifeSupportRating = $O2GenRating * $CO2ScrubberRating;

print "Life Support values - O2 Gen: $O2GenRating, CO2 Scrubber: $CO2ScrubberRating and Life Support Rating: $lifeSupportRating.\n";

exit(0);
#==========================================================================
