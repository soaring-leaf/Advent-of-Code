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
#open(INPUT,"<","testinput.txt") or die "Can't open testInput.txt $!";

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
print "Power values - Gamma: $gamma, Epsilon: $epsilon and Power Consumption: $powerConsumption.\n\n";


# Part 2 - Find the O2 Generator and CO2 Scrubber ratings
my @O2GenOptions; # Array of the Diagnostic Line options for the O2 Generator
my @CO2ScrubOptions; # same for the CO2 Scrubber
my @nextO2List = (); # Array to hold the next round of checks
my @nextCO2List = (); # Array to hold the next round of checks
my @O2BestMatch = (); # Array to hold the bit value of the O2 Generator Rating
my @CO2BestMatch = (); #Array to hold the bit value of the CO2 Scrubber Rating
my $gammaLeadBit = substr($gammaBitValue,0,1); # Value of the first bit of Gamma
my $currO2Count = 0; # current match value for the O2 Generator
my $currCO2Count = 0; # same for the CO2 Scrubber
my $maxBit = 0; # value of the bit found most frequently in the current check
my $minBit = 0; # value of the bit found least frequently in the current check
my $bitCount = 1; # Iterator for the Bit Position being reviewed

# Run through each Diagnostic row output and determine the diagnostic line options for each device
for(my $m=0; $m<scalar(@diagnosticRpt); $m++) {
    
    my @diagnosticVal = @{$diagnosticRpt[$m]};

    # Separate the diagnostic lines out into the device lists
    if($diagnosticVal[0] eq $gammaLeadBit) {
        push(@O2GenOptions,\@diagnosticVal);
    } else {
        push(@CO2ScrubOptions,\@diagnosticVal);
    }
}

$currO2Count = scalar(@O2GenOptions);
$currCO2Count = scalar(@CO2ScrubOptions);

# Find O2 Generator rating
while($currO2Count > 1) {
    @nextO2List = ();

    # find most frequent bit value for current position
    $maxBit = bitCounter(\@O2GenOptions,$bitCount,1);
    
    # build the next Option list from the current options
    for(my $n=0;$n<$currO2Count;$n++) {
        if($O2GenOptions[$n][$bitCount] == $maxBit) {
            push(@nextO2List,$O2GenOptions[$n]);
        }
    }

    $currO2Count = scalar(@nextO2List);
    @O2GenOptions = @nextO2List;
    $bitCount++;
}

@O2BestMatch = @{$O2GenOptions[0]};

# Find CO2 Scrubber rating
$bitCount = 1;

while($currCO2Count > 1) {
    @nextCO2List = ();

    # find least frequent bit value for current position
    $minBit = bitCounter(\@CO2ScrubOptions,$bitCount,0);
    
    # build the next Option list from the current options
    for(my $o=0; $o<$currCO2Count; $o++) {
        if($CO2ScrubOptions[$o][$bitCount] == $minBit) {
            push(@nextCO2List,$CO2ScrubOptions[$o]);
        }
    }

    $currCO2Count = scalar(@nextCO2List);
    @CO2ScrubOptions = @nextCO2List;
    $bitCount++;
}

@CO2BestMatch = @{$CO2ScrubOptions[0]};

# pull the Binary values of the ratings and convert to Decimal and then calc the Life Support rating
$O2GenRating = oct("0b".join('',@O2BestMatch));
$CO2ScrubberRating = oct("0b".join('',@CO2BestMatch));

$lifeSupportRating = $O2GenRating * $CO2ScrubberRating;

print "Life Support values - O2 Gen: $O2GenRating, CO2 Scrubber: $CO2ScrubberRating and Life Support Rating: $lifeSupportRating.\n";

exit(0);
#==========================================================================

# Takes the current array and dives through the current bit position to find 
# the most/least common bit value based on the device being searched for
# Input is the Diagnostic array being evaluated, Bit Position to check, and Device Flag
# Device Flag = 1 if O2 Generator, 0 if CO2 Scrubber
sub bitCounter {
    my $zeroCount = 0;
    my $oneCount = 0;
    my $deviceFlag = pop(@_);
    my $pos = pop(@_);
    my @options = @{$_[0]};
    
    for(my $i=0; $i<scalar(@options); $i++) {
        if($options[$i][$pos] eq '1') {
            $oneCount++;
        } else {
            $zeroCount++;
        }
    }

    # if the counts are the same, then adjust the count based on the device
    if($zeroCount == $oneCount) {
        if($deviceFlag == 1) {
            $oneCount++;
        } else {
            $zeroCount--;
        }
    }

    if($deviceFlag == 1) {
        if($oneCount > $zeroCount) {
            return 1;
        } else {
            return 0;
        }
    } else {
        if($zeroCount < $oneCount) {
            return 0;
        } else {
            return 1;
        }
    }
}