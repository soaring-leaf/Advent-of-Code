#!/usr/bin/perl
use warnings;
use strict;

my @passes;
my %seating;
my $seatID = 0;
my $testID = 0;
my $currRow = 0;
my $currSeat = 0;
my $found = 0;
my $seat = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	@passes = split('');
	for (my $i=0;$i<10;$i++) {
		if ($passes[$i] eq 'B') {
			if ($i == 0) {
				$currRow = 64;
			} elsif ($i == 1) {
				$currRow += 32;
			} elsif ($i == 2) {
				$currRow += 16;
			} elsif ($i == 3) {
				$currRow += 8; 
			} elsif ($i == 4) {
				$currRow += 4;
			} elsif ($i == 5) {
				$currRow += 2; 
			} else {
				$currRow += 1; 
			}
		} elsif ($passes[$i] eq 'R') {
			if ($i == 7) {
				$currSeat = 4;
			} elsif ($i == 8) {
				$currSeat += 2; 
			} else {
				$currSeat += 1;
			}
		}
	}
		
		$testID = $currRow * 8 + $currSeat;
		$seating{$testID} = 1;
		
		if ($testID > $seatID) {
			$seatID = $testID;
		}
		
		$currSeat = 0;
		$currRow = 0;
		$testID = 0;
}

close(INPUT);

for (my $m=0;$m<128;$m++) {
	for (my $n=0;$n<8;$n++) {
		$testID = $m * 8 + $n;
		#print "currently testing for $testID at $m, $n\n";
		
		if (!exists($seating{$testID})) {
			#print "this seat isn't found, checking for existance of adjacent seats\n";
			#print $testID - 1 . " " . exists($seating{($testID-1)}) . " and ";
			#print $testID + 1 . " " . exists($seating{($testID+1)}) . "\n";
				if (exists($seating{($testID-1)}) && exists($seating{($testID+1)})) {
						$found++;
						$seat = $testID;
						$currRow = $m;
						$currSeat = $n;
				}
		}
		
		if ($found) {
			$n = 8;
			$m = 128;
		}
	}
}

print "Largest SeatID is $seatID. \n";
print "My SeatID is $currRow, $currSeat with SeatID: $seat. \n";

exit(0);
#==========================================================================
