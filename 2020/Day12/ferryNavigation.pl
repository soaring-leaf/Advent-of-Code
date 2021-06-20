#!/usr/bin/perl
use warnings;
use strict;

my $EW = 0;			# Manhattan Distance for East/West
my $NS = 0;			# Manhattan Distance for N/S
my $heading = '1';	# Ferry Heading: 0 = North, 1 = E, 2 = S, 3 = W

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	my ($dir,$dist) = split('',$_,2);
	
	if ($dir eq 'F') {
		if ($heading == 0) {
			$dir = 'N';
		} elsif ($heading == 1) {
			$dir = 'E';
		} elsif ($heading == 2) {
			$dir = 'S';
		} elsif ($heading == 3) {
			$dir = 'W';
		} else {
			die "there is something wrong with the heading $heading \n";
		}
	}
	
	if ($dir eq 'W') {
		$EW -= $dist;
	} elsif ($dir eq 'E') {
		$EW += $dist;
	} elsif ($dir eq 'N') {
		$NS += $dist;
	} elsif ($dir eq 'S') {
		$NS -= $dist;
	} elsif ($dir eq 'R') {
		$heading = ($heading + ($dist/90)) % 4;
	} elsif ($dir eq 'L') { 
		$heading = ($heading - ($dist/90));
		
		if ($heading < 0) {
			$heading = 4 + $heading;
		}
	}
}

close(INPUT);

# repurpose $heading for Manhattan Distance total
$heading = abs($EW) + abs($NS);

print "We've gone $EW E/W and $NS N/S for a total of $heading\n";

exit(0);
#==========================================================================
