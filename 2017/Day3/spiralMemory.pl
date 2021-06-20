#!/usr/local/bin/perl
use warnings;
use strict;

my $elmt = 2;	  # counter for the memory cell
my $posX = 1;	  # Current positions for the memory cell
my $posY = 0;
my $direct = 2;   # Direction is 1=Rgt; 2=Up; 3=Lft; 4=Dn
my $goal = 277678; 	  # Puzzle input is 277678
my $dist = 0;
my $sqSize = 2;
my %mem;
my $val = 1;

$mem{"0,0"} = 1;
$mem{"1,0"} = 1;

while ($val < $goal) {
	$elmt++;
	
	if($direct == 1) {
		$posX++;
		# check if direction needs to be changed
		if (sqrt($elmt-1) == $sqSize) {
			$direct = 2;
			$sqSize++;
		}
		
		# find the value that goes in this memory cell
		$val = $mem{(join(',',$posX-1,$posY))} + $mem{join(',',$posX-1,$posY+1)};
		if(exists $mem{join(',',$posX,$posY+1)}) {
			$val = $val + $mem{join(',',$posX,$posY+1)};
		}
		if(exists $mem{join(',',$posX+1,$posY+1)}) {
			$val = $val + $mem{join(',',$posX+1,$posY+1)};
		}
	} elsif($direct == 4) {
		$posY--;
		
		if(($elmt+$sqSize-1) == $sqSize**2) {
			$direct = 1;
		}
		
		$val = $mem{(join(',',$posX+1,$posY+1))} + $mem{join(',',$posX,$posY+1)};
		if(exists $mem{join(',',$posX+1,$posY)}) {
			$val = $val + $mem{join(',',$posX+1,$posY)};
		}
		if(exists $mem{join(',',$posX+1,$posY-1)}) {
			$val = $val + $mem{join(',',$posX+1,$posY-1)};
		}
	} elsif($direct == 2) {
		$posY++;
		
		if(($elmt+$sqSize-1) == $sqSize**2) {
			$direct = 3;
		}
		
		$val = $mem{(join(',',$posX-1,$posY-1))} + $mem{join(',',$posX,$posY-1)};
		if(exists $mem{join(',',$posX-1,$posY)}) {
			$val = $val + $mem{join(',',$posX-1,$posY)};
		}
		if(exists $mem{join(',',$posX-1,$posY+1)}) {
			$val = $val + $mem{join(',',$posX-1,$posY+1)};
		}
	} elsif($direct == 3) {
		$posX--;
		
		if(sqrt($elmt-1) == $sqSize) {
			$sqSize++;
			$direct = 4;
		}
		
		$val = $mem{(join(',',$posX+1,$posY))} + $mem{join(',',$posX+1,$posY-1)};
		if(exists $mem{join(',',$posX,$posY-1)}) {
			$val = $val + $mem{join(',',$posX,$posY-1)};
		}
		if(exists $mem{join(',',$posX-1,$posY-1)}) {
			$val = $val + $mem{join(',',$posX-1,$posY-1)};
		}
	}
	#print "at mem cell $posX, $posY\n";
	$mem{join(',',$posX,$posY)} = $val;
	#print "value is $val at $posX, $posY\n";
}

$dist = abs($posX) + abs($posY);

print "Dist from goal to port is $dist \n";
print "First value written that is larger than the the input is $val\n";

exit 0;
#====================== End Main Section =============================

