#!/usr/local/bin/perl
use warnings;
use strict;

my $mcle = ''; # Calibration Molecule
my @inputs; # List of the input rows
my %subs; # Hash of the lists for each possible substitution
my %newMols; # Hash to hold the new molecules from Part1
my $element = ''; # Element to replace
my $rep = ''; # Replacement Molecule
my $totalNew = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file: $!";

while (<MYFILE>) {
	chomp($_);
	push(@inputs,$_);
}

close(MYFILE);

# Get the molecule from the end of the list and pop the blank line off the end
$mcle = pop(@inputs);
pop(@inputs);

for(my $i=0; $i<scalar(@inputs); $i++) {
	($element,$rep) = split(' => ',$inputs[$i]);
	
	if(exists($subs{$element})) {
		push(@{$subs{$element}},$rep);
	} else {
		my @arr = ($rep);
		$subs{$element} = \@arr;
	}
}

# Go through the Calibration Molecule and make a singular replacement
# Add each new molecule to the newMols hash
for(my $e=0; $e < length($mcle); $e++) {
	my $first = substr($mcle,0,$e);
	my $currEle = substr($mcle,$e,1);
	my $offset = 1;

	if($e < length($mcle)-1) {
		my $nextEle = substr($mcle,$e+1,1);

		if($nextEle eq lc($nextEle)) {
			$currEle = $currEle . $nextEle;
			$offset++;
		}
	}

	if(exists($subs{$currEle})) {
		foreach my $s (@{$subs{$currEle}}) {
			$newMols{$first . $s . substr($mcle,$e+$offset)} = 1;
		}
	}

	if($offset > 1) {
		$e++;
	}
}

print "Number of new molecules created is ".scalar(keys(%newMols))."\n";

exit 0;
#====================== End Main Section =============================

