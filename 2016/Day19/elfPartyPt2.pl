#!/usr/local/bin/perl
use warnings;
use strict;
use POSIX qw(ceil);

# Lots to still figure out like how to remove the elf that loses his presents

my %elves;
my $numElves = 5;	# 3001330 - puzzle input
my $count = 1;
my $loser = 0;	#  elf that gives up his presents

for (my $i=1;$i<=$numElves;$i++) {
	$elves{$i} = 1;
}

while (scalar(@elves) > 1) {
	print "working on iteration $count, array is now ".scalar(@elves)."\n";
	
	foreach my $e (keys %elves) {
		if (exists $elves{$e}) {
			$loser = ceil(scalar(keys %elves)/2);
			
			
		}
		
	}

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
