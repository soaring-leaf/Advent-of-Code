#!/usr/bin/perl
use warnings;
use strict;

my $EW = 0;			# Manhattan Distance for East/West
my $NS = 0;			# Manhattan Distance for N/S
my $wyptEW = 10;	# E/W position for Waypoint
my $wyptNS = 1;		# N/S position for Waypoint
my $holder = 0;		# Var to hold one Waypoint distance while adjusting
my $totalDist = 0;	

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	my ($dir,$dist) = split('',$_,2);
	
	if ($dir eq 'F') {
		$EW += ($wyptEW * $dist);
		$NS += ($wyptNS * $dist);
	} elsif ($dir eq 'W') {
		$wyptEW -= $dist;
	} elsif ($dir eq 'E') {
		$wyptEW += $dist;
	} elsif ($dir eq 'N') {
		$wyptNS += $dist;
	} elsif ($dir eq 'S') {
		$wyptNS -= $dist;
	} else { # $dir = R or L
		$dist = $dist/90;
		
		if ($dist == 0 || $dist == 2) {
			$wyptEW = $wyptEW * -1;
			$wyptNS = $wyptNS * -1;
		} elsif (($dir eq 'R' && $dist == 1) || ($dist == 3 && $dir eq 'L')) {
			$holder = $wyptEW;
			$wyptEW = $wyptNS;
			$wyptNS = $holder * -1;
		} elsif (($dir eq 'L' && $dist == 1) || ($dist == 3 && $dir eq 'R')) {
			$holder = $wyptNS;
			$wyptNS = $wyptEW;
			$wyptEW = $holder * -1;
		}
	}
	
	$totalDist++;
}

close(INPUT);

print "There are $totalDist actions to process\n";

$totalDist = abs($EW) + abs($NS);

print "We've gone $EW E/W and $NS N/S for a total of $totalDist\n";

exit(0);
#==========================================================================
