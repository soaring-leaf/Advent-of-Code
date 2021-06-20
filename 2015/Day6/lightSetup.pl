#!/usr/local/bin/perl
use warnings;
use strict;

my @lightGrid;
my @instr;
my $toDo;
my $lightCount = 0;
my $corner1;
my $corner2;

initGrid(\@lightGrid);

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	@instr = split(' ',$_);
	
	if ($instr[0] eq 'turn') {
		shift(@instr);
	}
	$toDo = shift(@instr);
	$corner1 = shift(@instr);
	$corner2 = pop(@instr);
	pop(@instr);
	
	update($corner1,$corner2,$toDo,\@lightGrid);
} # end while loop

close MYFILE;

$lightCount = getLights(\@lightGrid);

#print "$lightCount lights are on. \n";
print "Total brightness is $lightCount.\n";

exit 0;
#====================== End Main Section =============================
sub initGrid {
	my $ref = $_;
	
	for (my $i = 0; $i<1000;$i++) {
		for (my $k = 0; $k<1000;$k++) {
			$lightGrid[$i][$k] = 0;
		} #end nested for
	} #end for
}
sub update {
	my ($c1, $c2, $dir, $aRef) = @_;
	my ($x1,$y1) = split(',',$c1);
	my ($x2,$y2) = split(',',$c2);
	
	for (my $i=$x1; $i<=$x2;$i++) {
		for (my $k=$y1; $k<=$y2; $k++) {
			$aRef->[$i][$k] = adjustLight($aRef->[$i][$k],$dir);
		} #end nested for
	} #end for	
}

#takes Matrix reference; Returns number of lights in ON state
sub getLights {
	my $aRef = $_[0];
	my $count = 0;
	
	for (my $i=0; $i<1000;$i++) {
		for (my $k=0; $k<1000;$k++) {
			if ($aRef->[$i][$k] > 0) {
				$count = $count + $aRef->[$i][$k];
			} 
				
		} #end nested for
	} #end for
	
	return ($count);
}
	
#Takes current state and instruction for change
#Returns new state
sub adjustLight {
	my ($s, $d) = @_;

	if ($d eq 'off') {
		$s--;
		if ($s < 0) {
			$s = 0;
		}
	} elsif ($d eq 'on') {
		$s++;
	} else {
		$s = $s + 2;
#		if ($s eq '1') {
#			$s = 0;
#		} else {
#			$s = 1;
#		}
	}
	
	return $s;
}
