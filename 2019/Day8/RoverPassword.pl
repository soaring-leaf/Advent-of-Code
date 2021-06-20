#!/usr/bin/perl
use warnings;
use strict;

my $image = 0;
my $zCount = 0;
my $oCount = 0;
my $tCount = 0;
my $min = -1;
my $check = 0;
my $i=0;

open(INPUT,"<input.txt") or die "Unable to open input.txt: $!";

while(<INPUT>) {
	$image = $_;
	#print "length of image file is: ".length($image)."\n";
}

close(INPUT);

while($i < length($image)) {
	my $seg = substr($image,$i,150);
	$zCount = 0;
	$oCount = 0;
	$tCount = 0;
	
	# Check each layer for digit counts
	for(my $k=0;$k<150;$k++) {
		my $n = substr($seg,$k,1);
		if($n == 0) {
			$zCount++;
		} elsif($n ==1) {
			$oCount++;
		} else {
			$tCount++;
		}
	}
	
	if(($min == -1) || ($min > $zCount)) {
		$min = $zCount;
		$check = $oCount * $tCount;
	} 
	
	$i += 150;
}

print "CheckSum for Password Image is: $check \n";

exit(0);
#==========================================================================
