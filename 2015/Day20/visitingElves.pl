#!/usr/local/bin/perl
use warnings;
use strict;

my $num = 33100000;
my $found = 0;
my $house = 0;
my $count = 0;
my @elves;
my $high = $num;
my $max = 0;
my $low = 1;

while (!($found)) {
	
	$house = int(($high+$low)/2);	
	@elves = getFactors($house);
	$count = getPresentCount($house,@elves);
	
	if ($count < $num) {
		if ($high == $low) {
			$found = 1;
		}
		
		$low = $house + 1;	
	} elsif (($count >= $num) && ($high == $low)) {
		$max = $high;
		$low = 1;
		$high--;
	} else {
		$max = $house;
		$high = $house;
	}
	
	#print "on house $house, low is $low, high is $high, count is $count\n";

}

print "lowest house so far with target present count is $max\n";

for (my $i=1;$i<100000;$i++) {
	$high = $max - $i;
	@elves = getFactors($high);
	$count = getPresentCount($high,@elves);
	
	if (($i % 20000) == 0) {
		print "working on $high\n";
	}
	
	if ($count >= $num) {
		$max = $high;
		print "found new low at $max\n";
		$i = 1;
	}
}

print "lowest is $max\n";

exit(0);
#====================== End Main Section =============================
sub getFactors {
	my $num = $_[0];
	my $i = int(sqrt($num));
	my @f;
	
	while ($i > 0) {
		if ( ($num % $i) == 0 ) {
			push(@f,$i);
		}
		
		$i--;
	}
	
	my $x = scalar(@f);
	
	for (my $e=0;$e<$x;$e++) {
		$i = $num/$f[$e];
		push(@f,$i);
	}
		
	return (@f);
}

sub getPresentCount {
	my ($h, @elfList) = @_;
	my $c = 0;
	my $n = 0;
	my $e = 0;
	
	while (scalar(@elfList) > 0) {
		$e = pop(@elfList);
		if (($e * 50) >= $h) {
			$n = $e * 11;
			$c = $c + $n;
		}
	}
	
	return ($c);
}
