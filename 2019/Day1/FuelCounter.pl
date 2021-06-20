#!/usr/bin/perl
use warnings;
use strict;
use POSIX;

my $module = 0;
my $total = 0;
my $fuel = 0;
my $calc = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
	$module = $_;
	$fuel = floor($module/3) - 2;
	$fuel = fuelForFuel($fuel);
	$total += $fuel;
}

close(INPUT);

print "Total fuel needed is $total \n";

exit(0);
#==========================================================================
#Calculating fuel cost for fuel 
sub fuelForFuel {
	my $t = $_[0];
	my $f = $t;
	
	while($t > 0) {
		if(floor($t/3) - 2 > 0) {
			$t = floor($t/3) - 2;
			$f += $t;
		} else {
			$t = 0;
		}
	}
	
	return $f;
}

