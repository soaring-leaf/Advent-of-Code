#!/usr/local/bin/perl
use warnings;
use strict;

my $player = 2;
my @points = (0) x 418;
my @marbles = (0,1);
my $turn = 2;
my $mCurr = 1;
my $s = 0;
my $last = 0;
my $winner = 0;

# Part 1
#=================================
while($turn <= 70769) {
	if($turn % 23 == 0) {
		# Calc Points!
		if($mCurr > 6) {
			$mCurr = $mCurr - 7;
		} else {
			$s = 7 - $mCurr;
			$mCurr = scalar(@marbles) - $s;
		}
		$last = $turn + splice(@marbles,$mCurr,1);
		#print "Player $player scored $last on marble $turn\n";
		$points[$player] = $points[$player] + $last;
		
	} else {
		# Place Marble
		# Advance the Curr Counter to the new marble's position
		$mCurr = $mCurr + 2; 
		
		if($mCurr == scalar(@marbles)) {
			$marbles[$mCurr] = $turn;
		} elsif($mCurr > scalar(@marbles)) {
			$s = shift(@marbles);
			unshift(@marbles,($s,$turn));
			$mCurr = 1; # reset the Curr Counter for this case
		} else {
			splice(@marbles,$mCurr,0,$turn);
		}
	}
	
	$turn++;
	$s = 0;
	if($player == 417) {
		$player = 0;
	} else {
		$player++;
	}
}

foreach my $i (@points) {
	if($i > $winner) {
		$winner = $i;
	}
}

print "The Winner scored $winner points!\n";

# Part 2
#=================================


exit 0;
#====================== End Main Section =============================

