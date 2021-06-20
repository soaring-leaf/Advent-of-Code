#!/usr/local/bin/perl
use warnings;
use strict;
use Clone qw(clone);

my $line;
my @lights;
my @copy;
my $rCount = 0;

open(MYFILE,"<input.txt") or die "unable to open file: $!";

while (<MYFILE>) {
	chomp($_);
	$line = $_;
	initLights($line,$rCount,\@lights);
	
	$rCount++;
}

updateCorners(\@lights);

$rCount = countLights(\@lights);

print "there are $rCount lights on after no cycles.\n";


for (my $i=0;$i<100;$i++) {
	updateGrid(\@lights);
	updateCorners(\@lights);
}

$rCount = countLights(\@lights);

print "there are $rCount lights on after 100 cycles.\n";

exit(0);
#====================== End Main Section =============================
sub updateCorners {
	my $r = $_[0];
	
	$r->[0][0] = 1;
	$r->[0][99] = 1;
	$r->[99][0] = 1;
	$r->[99][99] = 1;
}

sub countLights {
	my $aRef = $_[0];
	my $count = 0;
	
	for (my $i=0; $i<100;$i++) {
		for (my $k=0; $k<100;$k++) {
			if ($aRef->[$i][$k]) {
				$count++;
			} 
				
		} #end nested for
	} #end for
	
	return ($count);
}

sub updateGrid {
	my $gRef = $_[0];
	my $gCopy = clone($_[0]);
	my $count = 0;
	
	for (my $r=0;$r<100;$r++) {
		for (my $c=0;$c<100;$c++) {
			$count = checkAdjacent($r,$c,$gCopy);
			
			#print "pos $r,$c; there are $count lights adj\n";
			#print "and the state of the light is " . $gCopy->[$r][$c] . "\n";
			
			if ($gCopy->[$r][$c]) {
				if (($count == 2) || ($count == 3) ) {
					#do nothing
				} else {
					$gRef->[$r][$c] = 0;
					#print "on light going off\n";
				}
				
			} else {
				if ($count == 3) {
					#print "off light going on\n";
					$gRef->[$r][$c] = 1;
				}
			}
		}
	}
	
}

sub checkAdjacent {
	my ($r,$c,$ref) = @_;
	my $numOn = 0;

	for (my $x=-1;$x<2;$x++) {
		if ( (($r+$x) > -1) && (($r+$x) < 100) ) {
			for (my $y=-1;$y<2;$y++) {
				if ( (($c+$y) > -1) && (($c+$y) < 100) ) {
					#print $ref->[($r+$x)][($c+$y)] . " " ;
						
					if ($ref->[($r+$x)][($c+$y)]) {
						$numOn++;
					}
				} # end nested if
			
			} #end nested for
			#print "\n";
		} #end if
	} #end for
	
	#don't count current light if it's on
	if ($ref->[$r][$c]) {
		$numOn--;
	}
	
	return ($numOn);
}

sub initLights {
	my ($L,$row,$aRef) = @_;
	my $light = 0;
	my $col = 0;
	my @setup = split('',$L);
	
	while (scalar(@setup) > 0) {
		$light = shift(@setup);
		
		if ($light eq '#') {
			$aRef->[$row][$col] = 1;
		} elsif ($light eq '.') {
			$aRef->[$row][$col] = 0;
		} else {
			die "bad input at $light.\n";
		}
		
		$col++;
	}
	#print "row is $row; col is $col\n";
}
