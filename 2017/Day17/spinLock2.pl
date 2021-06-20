#!/usr/local/bin/perl
use warnings;
use strict;

my $steps = 348; # actual input is 348
my @lock = (0,1);
my $pos = 1;
my $next = 0;
my $len = 0;

for(my $i=2;$i<2018;$i++) {
	$pos = ($pos + $steps) % scalar(@lock);	
	splice(@lock,$pos,0,$i);
	
	$pos++;
}

print "The value after 2017 is $lock[$pos] \n";

exit 0;
#====================== End Main Section =============================


