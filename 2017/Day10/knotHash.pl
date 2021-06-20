#!/usr/local/bin/perl
use warnings;
use strict;

my @items = (0 .. 255);
my @steps;		# Num of elements to grab and reverse each step
my @workIt;		# array of elements to reverse
my $wCount = 0;		# length of items pulled from array to reverse
my $pos = 0;		# current position to start grabbing elements
my $skip = 0;		# elements to skip after advancing to next position

#open (MYFILE,"<test.txt") or die "Can't open input file: $!";
open (MYFILE,"<input.txt") or die "Can't open input file: $!";

while(<MYFILE>) {
	chomp($_);
	@steps = split(',');	
}

close(MYFILE);

foreach my $r (@steps) {
	@workIt = ();
	$wCount = 0;
	
	#print "position is at $pos\n";
	# copy section to be reversed
	while ($wCount < $r) {
		if( ($wCount + $pos) < scalar(@items) ) {
			push(@workIt,$items[$wCount+$pos]);
		} else { 
			push(@workIt,$items[($wCount+$pos-256)]);
		}
		$wCount++;
	} # End While loop
	
	#print "before reverse ";
	#print @workIt;print "\n";
	@workIt = reverse(@workIt);
	#print @workIt; print"\n";
	
	# Put reversed section back into array
	$wCount = 0;
	while ($wCount < $r) {
		if ( ($wCount + $pos) < scalar(@items) ) {
			$items[($wCount+$pos)] = $workIt[$wCount];
		} else {
			$items[($wCount+$pos-256)] = $workIt[$wCount];
		}
		$wCount++;
	} # End While loop
	$pos = ($pos + scalar(@workIt) + $skip) % 256;
	$skip++;
	#print @items;
	#print "\n";
} # End foreach loop

print "The product of the first two items is: ". $items[0] * $items[1] . "\n";

exit 0;
#====================== End Main Section =============================

