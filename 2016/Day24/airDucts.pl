#!usr/local/bin/perl
use warnings;
use strict;
use Storable qw(dclone);
use Data::Dumper;

# to make a copy of the map:
#my @mapCopy = @{ dclone(\@map) };

my @map;	# map of ducts
my @paths;
my %poi;	# points of interest for robot to get to
my $char = '';
my $x = 0;
my $y = 0;
my $count = 0;

# input map has 183 rows, test has 11
for (my $i=0;$i<183;$i++) {
	my @a = ();
	push(@map,\@a);
}

open(MYFILE,"<input.txt") or die "Can't open input file: $!";
#open(OUTPUT,">out.txt") or die "Can't open output file: $!";

#print OUTPUT "Original Map:\n";
while (<MYFILE>) {
	chomp($_);
	for (my $i=0;$i<length($_);$i++) {
		$char = substr($_,$i,1);
#		print OUTPUT $char;
		if (($char ne '.') && ($char ne '#')) { # find points of interest
			$x = $i;
			$y = $count;
			$poi{$char} = $x.' '.$y; # For POI x, we now have the coords and a clean map
			$char = '.';
		}
		push($map[$i],$char);
	}
#	print OUTPUT "\n";
	$count++;
}
#print OUTPUT "\n\n";
close(MYFILE);

# create a copy of the map for each POI
my @map1 = @{ dclone(\@map) };
my @map2 = @{ dclone(\@map) };
my @map3 = @{ dclone(\@map) };
my @map4 = @{ dclone(\@map) };
my @map5 = @{ dclone(\@map) };
my @map6 = @{ dclone(\@map) };
my @map7 = @{ dclone(\@map) };
my @maps = (\@map,\@map1,\@map2,\@map3,\@map4,\@map5,\@map6,\@map7);

# Record in each map the distances to each reachable point from that map's POI
for (my $i=0;$i<8;$i++) {
	my $coord = $poi{$i};
	($x, $y) = split(' ',$coord);
	calcPaths($maps[$i],$x,$y,0);
	
#	my @m = @{$maps[$i]};
	
}

#	print OUTPUT "Map from point 2\n";
#	for (my $r=0;$r<37;$r++) {
#		for (my $c=0;$c<183;$c++) {
#			if (($map2[$c][$r] eq '.') || ($map2[$c][$r] eq '#')) {
#				print OUTPUT $map2[$c][$r];
#			} else {
#				print OUTPUT ' ';
#			}
#		}
#		print OUTPUT "\n";
#	}
#	print OUTPUT "\n\n";

@paths = sort { $a <=> $b } keys(%poi);

@paths = getAllPaths(@paths);

#print OUTPUT Dumper(\@map2);

$count = getShortest(\@paths,\@maps,\%poi);

print "\n\nShortest path to all POI is $count\n";

#close(OUTPUT);
exit 0;
# ======================= End Main Section ===========================
sub getShortest {
	my $pthsR = shift;
	my $mapsR= shift;
	my $ptsR = shift;
	my $min = -1;
	my $currLen = 0;
	my $x = 0;
	my $y = 0;
	
	foreach my $e (@{$pthsR}) {
		my @currPath = @{$e};
#		print Dumper(\@currPath);
		for (my $p=1;$p<scalar(@currPath);$p++) {
			($x, $y) = split(' ',$ptsR->{($currPath[$p])});
			$currLen += $mapsR->[$currPath[$p-1]][$x][$y];
		}
		if (($min == -1) || ($min > $currLen)) {
			$min = $currLen;
		}
		$currLen = 0;
	}
	
	return $min;	
}
sub getAllPaths {
	my @a = @_;
	my @p;
	
	if (scalar(@a) == 2) {
		my @a1 = (($a[0]+0),($a[1]+0));
		push(@p,\@a1);
		my @a2 = (($a[1]+0),($a[0]+0));
		push(@p,\@a2);
		return @p;
	}
	
	my $curr = shift(@a)+0;
	
	if ($curr == 0) {
		@p = getAllPaths(@a);
		foreach my $e (@p) {
			unshift($e,0);
			push($e,0);
		}
	} else {
		@p = getAllPaths(@a);
		my @c = @{ dclone(\@p) };
		my $len = scalar(@{$p[0]});
		for (my $i=0;$i<$len;$i++) {
			if ($i == 0) {
				foreach my $e (@p) {
					unshift($e,$curr);
				}
			} else {
				for (my $cpy=0;$cpy<scalar(@c);$cpy++) {
					my @next = @{$c[$cpy]};
					splice(@next,$i,0,$curr);
					push(@p,\@next);
				}	
			}
		}
		# add the current to the end of the paths
		foreach my $e (@c) {
			push($e,$curr);
			push(@p,$e);
		}
	}
	
	return @p;
}

# Caluclates the shortest number of steps to each open spot from a designated origin
sub calcPaths {
	my $m = shift;	# Reference to the map
	my $x = shift;	# starting coords
	my $y = shift;
	my $step = shift;	# num of steps currently taken, initial call will be 0
	my $v = $m->[$x][$y];
	
	#print "at coords $x $y\n";
	
	# set adjacent moves to $step + 1 
	# unless adjacent coord holds value less than step
	# move to that coord if SET OR UPDATED from THIS COORD ONLY
	
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
	if (($x+1) < 183) {
		if ($m->[$x+1][$y] ne '#') {
			if (($m->[$x+1][$y] eq '.') || ($m->[$x+1][$y] > ($step+1)))  {
				$m->[$x+1][$y] = $step + 1;
				calcPaths($m,($x+1),$y,($step+1));
			}
		}
	}
	
	# check South
	if (($y+1) < 37) {
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
