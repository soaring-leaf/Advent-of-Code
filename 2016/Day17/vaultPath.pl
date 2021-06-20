#!/usr/local/bin/perl
use warnings;
use strict;
use Digest::MD5 qw(md5 md5_hex md5_base64);

# STILL NEED TO FIGURE OUT THE RECURSION
# AND WHAT TO RETURN

my $pscd = 'pvhmgsws'
my $path = '';
my $len = 0;
my $posX = 0;
my $posY = 0;

($len, $path) = findPath($pscd, $path, $posX, $posY);

print "path to the vault is: $path\n";

exit 0;
#====================== End Main Section =============================
sub findPath {
	my $code = shift;
	my $pth = shift; # path up to this current coord
	my $x = shift;	 # X coord for current position
	my $y = shift;	 # Y coord for current position
	my $doors = '';	 # string to hold door keys
	my $len = 0;	# length of the shortest path found so far
	my $nPth = '';	# latest path found
	my $nLen = 0;	# length of latest path found
	
	# base case: found the vault
	if (($x == 3) && ($y == 3)) {
		return (length($path),$path);
	}
	
	# to protect against an infinite UDUDUD...UDUDUD... scenario
	# limiting the path check to a length of 50
	if ($L > 50) {
		return (-1,'');
	}
	
	$doors = getHash($code.$pth);
	
	# If statements checking each door if it's open
	# check each door, 0=up, 1=down, 2=left, 3=right
	for (my $i=0;$i<4;$i++) {
		if (isOpen($door,$i)) {
			# if door is open check for a path to the vault
			if (($i == 0) && ($y != 0)) {
				# going up
				($nLen,$nPath) = findPath($code,$pth.'U',$x,($y-1));
			} elsif (($i == 1) && ($y != 3)) {
				# going down
				($nLen,$nPath) = findPath($code,$pth.'D',$x,($y+1));
			} elsif (($i == 2) && ($x != 0)) {
				#going left
				($nLen,$nPath) = findPath($code,$pth.'L',($x-1),$y);
			} elsif (($i == 3) && ($x != 3)) {
				#going right
				($nLen,$nPath) = findPath($code,$pth.'R',($x+1),$y);
			}
			
			if ((($nLen != -1) && ($nLen < $L)) || (($nLen > 0) && ($L == 0))) {
				$L = $nLen;
				$pth = $nPath;
			}
		}
	}
	
	# if no doors are open (new length hasn't changed)
	# That means a path to the vault wasn't found from
	# the givin path to get to the current position
	if ($nLen == 0) {
		return (-1,'');
	} else {
		return ($L,$pth);
	}
}

# Check to see if specific door is open
# from the door string provided
sub isOpen {
	my $s = shift;
	my $i = shift;
	my $c = substr($s,$i,1);
	
	if (($c eq 'b') || ($c eq 'c') || ($c eq 'd') || ($c eq 'e') || ($c eq 'f')) {
		return 1;
	} else {
		return 0;
	}	
}

# Gets hash, returns the 4 char string representing the 
# status of the doors to the current room
sub getHash {
	my $s = shift;
	my $h = '';
	
	$h = md5_hex($s);
	
	return substr($h,0,4);
}
