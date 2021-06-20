#!/usr/local/bin/perl
use warnings;
use strict;
use Data::Dumper;

my $val = 0;
my @maze;

for (my $i=0;$i<50;$i++) {
	my @a = ();
	push(@maze,\@a);
}

for (my $x=0;$x<50;$x++) {
	for (my $y=0;$y<50;$y++) {
		if (getCoordVal($x,$y)) {
			push($maze[$x],"#");
		} else {
			push($maze[$x],'.');
		}
		
	}	
}

$maze[1][1] = 0; # sets starting point at 0 steps

#print Dumper @maze;
#open (OUTPUT,">out.txt") or die "Can't open output file: $!";

#for (my $y=0;$y<50;$y++) {
#	for (my $x=0;$x<50;$x++) {
#		print OUTPUT $maze[$x][$y];
#	}
#	print OUTPUT "\n";	
#}

calcPaths(\@maze,1,1,0);

$val = 0;
for (my $y=0;$y<50;$y++) {
	for (my $x=0;$x<50;$x++) {
		if (($maze[$x][$y] ne '#') && ($maze[$x][$y] ne '.') && ($maze[$x][$y] < 51)) {
			$val++;
		}
	}	
}

print "shortest distance to 31,39 is ".$maze[31][39]."\n";

print "Number of coords that can be reached in 50 steps or less is $val\n";

exit 0;
#====================== End Main Section =============================
sub calcPaths {
	my $m = shift;
	my $x = shift;
	my $y = shift;
	my $step = shift;
	my $v = $m->[$x][$y];
	
	#print "at coords $x $y\n";
	
	# set adjacent moves to $step + 1 
	# unless adjacent coord holds value less than step
	# move to that coord IF SET OR UPDATED FROM THIS COORD ONLY
	
	# check North
	if (($y-1) >= 0) {
		if ($m->[$x][$y-1] ne '#') {
			if (($m->[$x][$y-1] eq '.') || ($m->[$x][$y-1] > ($step+1)))  {
				$m->[$x][$y-1] = $step + 1;
				calcPaths($m,$x,($y-1),($step+1));
			}
		}
	}
	
	# check West
	if (($x-1) >= 0) {
		if ($m->[$x-1][$y] ne '#') {
			if (($m->[$x-1][$y] eq '.') || ($m->[$x-1][$y] > ($step+1)))  {
				$m->[$x-1][$y] = $step + 1;
				calcPaths($m,($x-1),$y,($step+1));
			}
		}
	}
	
	# check East
	if (($x+1) < 50) {
		if ($m->[$x+1][$y] ne '#') {
			if (($m->[$x+1][$y] eq '.') || ($m->[$x+1][$y] > ($step+1)))  {
				$m->[$x+1][$y] = $step + 1;
				calcPaths($m,($x+1),$y,($step+1));
			}
		}
	}
	
	# check South
	if (($y+1) < 50) {
		if ($m->[$x][$y+1] ne '#') {
			if (($m->[$x][$y+1] eq '.') || ($m->[$x][$y+1] > ($step+1)))  {
				$m->[$x][$y+1] = $step + 1;
				calcPaths($m,$x,($y+1),($step+1));
			}
		}
	}
	
}
	
# calculates coord and determines if it is a wall
# returns 1 (true) if wall, 0 (false) if not
sub getCoordVal {
	my $x = shift;
	my $y = shift;
	my $num = 0;
	my $fN = 1350;
	my $count = 0;
	my @n;
	
	$num = ($x*$x) + (3*$x) + (2*$x*$y) + $y + ($y*$y) + $fN;
	$num = dec2bin($num);
	@n = split('',$num);
	
	foreach my $e (@n) {
		if ($e == 1) {
			$count++;
		}
	}
	
	if (($count % 2) == 0) {
		return 0;
	} else {
		return 1;
	}	
}

sub dec2bin {
    my $str = unpack("B32", pack("N", shift));
    $str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
    return $str;
}
