#!/usr/local/bin/perl
use warnings;
use strict;

my @maxMin = (-1,0,-1,0,); # Min X, Max X, Min Y, Max Y Coordinates
my @coords;
my @timePlane;
my $count = 0;


for(my $init=0;$init<358;$init++) {
	push(@timePlane,[('.') x 358]);
}

open (MYFILE,"<input.txt") or die "Can't open file: $!";

while (<MYFILE>) {
	chomp;
	my($x,$y) = split(', ');
	
	if($maxMin[0] == -1 || $x < $maxMin[0]) {
		$maxMin[0] = $x;
	}
	if($x > $maxMin[1]) {
		$maxMin[1] = $x;
	}
	if($maxMin[2] == -1 || $y < $maxMin[2]) {
		$maxMin[2] = $y;
	}
	if($y > $maxMin[3]) {
		$maxMin[3] = $y;
	}
	
	$timePlane[$x,$y] = $count;
	
	push(@coords,"$x $y");
	$count++;
}

close(MYFILE);

# Part 1
#=================================
print "area of concern is $maxMin[0] to $maxMin[1] by $maxMin[2] to $maxMin[3]\n";

for($x=$maxMin[0];$x<$maxMin[1];$x++) {
	for($y=$maxMin[2];$y<$maxMin[3];$y++) {
		
		
	}
}

# Part 2
#=================================


exit 0;
#====================== End Main Section =============================

