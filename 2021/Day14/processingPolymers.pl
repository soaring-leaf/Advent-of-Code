#!/usr/bin/perl
use warnings;
use strict;

my %polyTemplate; # hash for holding all the translation pairs
my $polymer = ''; # string holding the polymer
my %elements; # hash for tracking element counts
my $mostCommon = 0; # indicates count of the most common element in Polymer
my $leastCommon = -1; # count of least common element


open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

# read in the polymer
$polymer = <INPUT>;
chomp($polymer);

print "polymer: $polymer\n";

# read the next blank line so the while can process the template mapping
<INPUT>;

while(<INPUT>) {
    chomp;
    
    my ($pairing, $rule) = split(' -> ');
    
    # Add the first element of the pairing to the result because
    # it needs to be added back anyway
    $polyTemplate{$pairing} = substr($pairing,0,1) . $rule;

    $elements{$rule} = 0;
}

close(INPUT);

# count current elements in polymer
my @eleArray = split('',$polymer);

foreach my $e (@eleArray) {
    $elements{$e}++;
}

# Process the polymer 10 times
for(my $i=0; $i < 10; $i++) {
    $polymer = processPolymer($polymer,\%elements,\%polyTemplate);
}

($mostCommon, $leastCommon) = getMostLeastFrequent(\%elements);

# Part 1 answer:
print "Difference between the Most and Least common elements is " . ($mostCommon - $leastCommon) . "\n\n";

# Part 2 answer:
# EFFICIENCY ISSUE with 40 steps...will take too long to complete
#print "\n\n";

exit(0);
#==========================================================================

sub getMostLeastFrequent {
    my %eleHash = %{$_[0]};
    my $big = 0;
    my $little = -1;

    foreach my $e (keys(%eleHash)) {
        #print "$e: $eleHash{$e}\n";
        if($eleHash{$e} > $big) {
            $big = $eleHash{$e};
        }

        if($eleHash{$e} != 0 && ($eleHash{$e} < $little || $little == -1)) {
            $little = $eleHash{$e};
        }
    }

    return ($big, $little);
}

sub processPolymer {
    my ($poly, $eleCountRef, $templateRef) = @_;
    my $newPoly = '';

    for(my $i=0; $i < length($poly) - 1; $i++) {
        my $currPair = substr($poly,$i,2);

        if(exists($templateRef->{$currPair})) {
            $newPoly = $newPoly . $templateRef->{$currPair};
            $eleCountRef->{substr($templateRef->{$currPair},1,1)}++;
        } else {
            $newPoly = $newPoly . substr($currPair,0,1);
        }
    }

    $newPoly = $newPoly . substr($poly,-1);

    return $newPoly;
}