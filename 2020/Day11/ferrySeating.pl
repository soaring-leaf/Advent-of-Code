#!/usr/bin/perl
use warnings;
use strict;
use Storable qw(dclone);

my @seating = ();		# Seating array
my @prevConfig = ();	# Secondary seating array to check previous config
my $rows = 0;			# Number of Rows in the Seating
my $numSeats = 0;		# Number of seats per Row
my $stable = 0;			# Flag to check if seating has stablized
my $count = 0;			# Counter for cycles

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	my @temp1 = split('');
	
	$numSeats = scalar(@temp1);
	
	for (my $e=0;$e<scalar(@temp1);$e++) {
		if ($temp1[$e] eq 'L') {
			$temp1[$e] = 'X';
		}
	}
	
	push(@seating,\@temp1);	# setup first cycle
	
	$rows++;
}

close(INPUT);

print "I've got $rows rows of seats with $numSeats in each row.\n";

$count++; # first cycle already happened in setup
@prevConfig = @{ dclone(\@seating) }; # seating not stablized yet, so copy current layout

while ($stable == 0) {
	seatCycle(\@seating,\@prevConfig,$rows,$numSeats);
	
	$count++; # count seat cycle

	$stable = checkChanges(\@seating,\@prevConfig,$rows,$numSeats);
	
	if ($stable == 0) {
		# if not yet stable then copy seating to prevConfig
		@prevConfig = ();
		@prevConfig = @{ dclone(\@seating) };
	}
	
	# Testing limit to prevent infinite looping
	# if ($count > 10) {
		# $stable = -1;
		# print "something is not right\n";
	# }
}

$count--; # since things stablize on last round, don't count it

print "$stable seats are occupied once things stablize (after $count cycles).\n";

exit(0);
#==========================================================================
sub checkChanges {
	my @curr = @{ $_[0] };
	my @prev = @{ $_[1] };
	my $y = $_[2];
	my $x = $_[3];
	my $occupied = 0;
	
	for (my $r=0;$r<$y;$r++) {
		for (my $c=0;$c<$x;$c++) {
			
			if($curr[$r][$c] eq 'X') { 
				# count occupied seats
				$occupied++;
			}
			
			if($curr[$r][$c] ne $prev[$r][$c]) {
				# if seating hasn't stablized, reset and end comparison
				$c = $x;
				$r = $y;
				$occupied = 0;
			}
		}
	}
	
	return $occupied;
} # end checkChanges
				
# Reference to Seating is first item sent
# using reference, update Seating based on current copy
sub seatCycle {
	my $nextRef = $_[0];	# Ref to Seating
	my $currRef = $_[1];	# Ref to current setup
	my $rMax = $_[2];		# Max rows
	my $cMax = $_[3];		# Max seats per row
	my $oCount = 0; # surrounding seats that are occupied
	
	for (my $r=0;$r<$rMax;$r++) {
		for (my $c=0;$c<$cMax;$c++) {
			
			if ($nextRef->[$r][$c] ne '.') {
				# check forward seats if not the first row
				if ($r != 0) {
					if ($currRef->[($r-1)][($c)] eq 'X') {
						$oCount++;
					}
					if ($c != 0) {
						if ($currRef->[($r-1)][($c-1)] eq 'X') {
							$oCount++;
						}
					}
					if ($c != ($cMax-1)) {
						if ($currRef->[($r-1)][($c+1)] eq 'X') {
							$oCount++;
						}
					}
				}
				# check backward seats if not the last row
				if ($r != ($rMax-1)) {
					if ($currRef->[($r+1)][($c)] eq 'X') {
						$oCount++;
					}
					if ($c != 0) {
						if ($currRef->[($r+1)][($c-1)] eq 'X') {
							$oCount++;
						}
					}
					if ($c != ($cMax-1)) {
						if ($currRef->[($r+1)][($c+1)] eq 'X') {
							$oCount++;
						}
					}
				}
				# check left if not on the edge
				if ($c != 0) {
					if ($currRef->[($r)][($c-1)] eq 'X') {
						$oCount++;
					}
				}
				# check right if not on the edge
				if ($c != ($cMax-1)) {
					if ($currRef->[($r)][($c+1)] eq 'X') {
						$oCount++;
					}
				}
				
				if ($currRef->[$r][$c] eq 'X' && $oCount > 3) {
					$nextRef->[$r][$c] = 'L';
				}
				if ($currRef->[$r][$c] eq 'L' && $oCount == 0) {
					$nextRef->[$r][$c] = 'X';
				}
				
				#reset for next check
				$oCount = 0;
				
			} # end seat check
		} # end column for loop
	} # end row for loop
}