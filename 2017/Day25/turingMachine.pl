#!/usr/local/bin/perl
use warnings;
use strict;

my @tape = (0);
my $curr = 0;
my $state = 'a';
my $steps = 0;
my $checkSum = 0;

while ($steps < 12368930) {
	$steps++;
	
	if($state eq 'a') {
		if($tape[$curr] == 0) {
			$tape[$curr] = 1;
			$state = 'b';
		} else {
			$tape[$curr] = 0;
			$state = 'c';			
		}
		
		# move to right, check if defined yet
		$curr++;
		if(! defined($tape[$curr])) {
			$tape[$curr] = 0;
		}
	} elsif($state eq 'b') {
		if($tape[$curr] == 0) {
			$state = 'a';
			if($curr == 0) { # move left, add element if at start of array
				unshift(@tape,0);
			} else {
				$curr--;
			}
		} else {
			$tape[$curr] = 0;
			$state = 'd';
			$curr++;
			if(! defined($tape[$curr])) {
				$tape[$curr] = 0;
			}
		}
	} elsif($state eq 'c') {
		if($tape[$curr] == 0) {
			$tape[$curr]++;
			$state = 'd';
		} else {
			$state = 'a';
		}
		
		$curr++;
		if(! defined($tape[$curr])) {
			$tape[$curr] = 0;
		}
	} elsif($state eq 'd') {
		if($tape[$curr] == 0) {
			$tape[$curr]++;
			$state = 'e';
		} else {
			$tape[$curr]--;
			$state = 'd';
		}
		
		if($curr == 0) {
			unshift(@tape,0);
		} else {
			$curr--;
		}
	} elsif($state eq 'e') {
		if($tape[$curr] == 0) {
			$tape[$curr]++;
			$curr++;
			$state = 'f';
			if(! defined($tape[$curr])) {
				$tape[$curr] = 0;
			}
		} else {
			$state = 'b';
			if($curr == 0) {
				unshift(@tape,0);
			} else {
				$curr--;
			}
		}
	} else {
		if($tape[$curr] == 0) {
			$tape[$curr]++;
			$state = 'a';
		} else {
			$state = 'e';
		}
		
		$curr++;
		if(! defined($tape[$curr])) {
			$tape[$curr] = 0;
		}
	} 
} # end while

foreach my $e (@tape) {
	$checkSum = $checkSum + $e;
}

print "Checksum is $checkSum \n";

exit 0;
#====================== End Main Section =============================


