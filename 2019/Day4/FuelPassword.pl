#!/usr/bin/perl
use warnings;
use strict;

my $pin = 193651;
my $max = 649729;
my $count = 0;	# Number of possible PINs 
my $decrease = 0;	# Flag for noting a digit decrease
my $dFlag = 0;	# Flag for finding Doubles
my $n1 = 0;
my $n2 = 0;
my $multi = 0;	# For determining if we are in a multi-digit situation
my $mFlag = 0;	# "
my $mCount = 0; # "

while ($pin < $max) {
	$dFlag = 0;
	$decrease = -1;
	$multi = -1;
	$mFlag = 0;
	$mCount = 0;
	
	for (my $i=0;$i<5;$i++) {
		$n1 = substr($pin,$i,1);
		$n2 = substr($pin,$i+1,1);
		
		if($n1 == $n2) {
			#$dFlag++;		# OK for Part 1 but Part 2 needs exactly a double
			$mFlag = 1;
			$mCount++;
			
			if($multi == -1) {
				$multi = $n1;
			}
		}
		
		# Find if there is a double
		if(($mFlag) && (($multi != $n2) || ($i == 4))) {
			if($mCount == 1) {					
				$dFlag++;
			} else {
				$mFlag = 0;
				$multi = -1;
				$mCount = 0;
			}
		}
				
		if($n1 > $n2) {
			$decrease = $i;
			$i = 5;
		}
	} # End For Loop check of current PIN
	
	if(($decrease == -1) && ($dFlag > 0)) {
		$count++;
		$pin++;
	} else {
		$pin++;		
	}
}

print "Number of possible PINs: $count \n";

exit(0);
#==========================================================================
