#!/usr/local/bin/perl
use warnings;
use strict;

my @elves;
my @e2;
my $numElves = 3001330;	# 3001330 - puzzle input
my $count = 1;
my $start = 0;
my $last = 1;		# if last amount of elves was even, start at 1

for (my $i=1;$i<=$numElves;$i=$i+2) {
	push(@elves,$i);
}

while (scalar(@elves) > 1) {
	print "working on iteration $count, array is now ".scalar(@elves)."\n";
	
	for (my $i=0;$i<scalar(@elves);$i++) {
		if ($i % 2 == 0) {
			if ($i == (scalar(@elves)-1)) {
				shift(@e2);
			}
			push(@e2,$elves[$i]);
		}
	}
	print "finished with iteration $count\n";
	@elves = @e2;
	@e2 = ();
	print "finished transferring the arrays\n";

# CAN'T USE SPLICE, TAKES WAY TOO LONG ON MASSIVE ARRAY
#
#	if ((scalar(@elves) % 2) == 0) {
#		$start = 1;
#	} else {
#		$start = 0;
#	}
#	
#	for (my $i = $start;$i<scalar(@elves);$i++) {
#		if (($start == 0) && ($i == (scalar(@elves)-1))) {
#			splice(@elves,0,1);
#		} else {
#			splice(@elves,$i,1);
#		}
#	}
	
	$count++;	
}

print "elf number $elves[0] got all the presents";

exit 0;
# ========================= End Main Section ==================================
sub oldAttepmt {
	
	
}
