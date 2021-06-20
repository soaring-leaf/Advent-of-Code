#!/usr/bin/perl
use warnings;
use strict;

my $time = 0;
my @busList = ();
my @busSched = ();
my $minWait = -1;
my $minBus = -1;
my $currBus = 0;
my $currWait = 0;
my $busStop = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	if($time != 0) {
		#process busses
		@busSched = split(',');
		foreach my $e (@busSched) {
			if ($e ne 'x') {
				push(@busList,$e);
			}
		}
	} else {
		$time = $_;
	}
}

close(INPUT);

for (my $i=0;$i<scalar(@busList);$i++) {
	$currBus = $busList[$i];
	$busStop = int($time/$currBus)+1;
	$busStop = $currBus * $busStop;
	$currWait = $busStop - $time;
	
	if (($minWait > $currWait) || $minBus == -1) {
		$minBus = $currBus;
		$minWait = $currWait;
	}
}

print "Earliest bus is $minBus with a wait time of $minWait for a Bus/Wait value of " . $minBus*$minWait ."\n";

# Reset the Time for Part 2
$time = 0;
my $noSolution = 0;
my $gapCount = 0;
my $gapToMax = 0;

@busList = sort { $b <=> $a } @busList;

print "largest bus is $busList[0] \n";

for(my $b=0;$busSched[$b]ne$busList[0];$b++) {
	$gapToMax++;
}

print "gap to the largest Bus ID is $gapToMax which is $busSched[$gapToMax]\n";

#initial Time to check
$time = $busList[0] - $gapToMax;

print "initial Time is $time \n";

while (!$noSolution) {
	$time += $busList[0];
	#print "current time check is $time \n";
	
	for (my $k=0;$k<scalar(@busSched);$k++) {
		if($busSched[$k] eq 'x') {
			$gapCount++;
		} else {
			if ( (($time+$gapCount) % ($busSched[$k])) != 0 ) {
				$k = scalar(@busSched);
				$gapCount = 0;
				$noSolution = -1;
			} else {
				$gapCount++;
			}
		}
		
	}
	
	$noSolution++; # if time not good, reset to false (0), otherwise increase to true (1)		
	
	#if ($time > 10000000) {
	#	$noSolution++; # break loop
	#}
}

print "Solution found at time $time\n";

exit(0);
#==========================================================================
