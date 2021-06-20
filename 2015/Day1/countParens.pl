#!/usr/local/bin/perl
use warnings;
use strict;

my $floor = 0;
my $myStr = 0;
my $count = 0;
my $found = 0;
my $maxFloor = 0;
my $minFloor = 0;
my $fileName = 'input.txt';
my @chars;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	$myStr = $_;
	@chars = split('',$myStr);
#	$floor = checkchar($myChar);

	for (my $i=0; $i < scalar(@chars); $i++) {
		
		if ($chars[$i] eq '(' ) {
			$floor++;
		} else {
			$floor--;
		}
		
		$count++;
		
		($maxFloor,$minFloor) = checkMaxMin($floor,$maxFloor,$minFloor);
		
		if ($floor eq '-1' && $found == 0) {
			print "Just entered basement for first time at $count. \n";
			$found = $count;
		}

	} #end For
	
} # end while loop

close MYFILE;
print "Final floor is $floor. \n";
print "Highest floor reached is $maxFloor. \n";
print "Lowest sub-basement reached is $minFloor. \n";

exit 0;
#====================== End Main Section =============================

sub checkMaxMin {
	my ($f, $max, $min) = @_;
	
	if ($f < $min) {
		$min = $f;
	}
	
	if ($f > $max) {
		$max = $f;
	}
	
	return ($max, $min);
}
