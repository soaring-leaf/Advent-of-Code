#!/usr/local/bin/perl
use warnings;
use strict;

my @instr; 	# string for instructions for each digit
my $dir = '';	# character for next move
my @code;
my $stateRow = 2;
my $stateCol = 0;
#my @pad = ( [1,2,3],[4,5,6],[7,8,9] );
my @pad = ( [undef,undef,1,undef,undef],[undef,2,3,4,undef],[5,6,7,8,9],[undef,'A','B','C',undef],[undef,undef,'D',undef,undef] );
open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	@instr = split("",$_);
	#print "length of array is ".scalar(@instr)."\n";
	
	#for each character, determine move
	#at end of string, number at the state of things is the next code number
	foreach $dir (@instr) {
		
		if ($dir eq 'D') {
			if ($pad[($stateRow+1)][$stateCol]) {
				$stateRow++;
			}
			#$stateRow = updateRow($dir,$stateRow,$stateCol,@pad);
		} elsif ($dir eq 'U') {
			if (($stateRow-1) >= 0 && $pad[($stateRow-1)][$stateCol]) {
				$stateRow--;
			}
		} elsif ($dir eq 'R') {
			if ($pad[$stateRow][($stateCol+1)]) {
				$stateCol++;
			}
			#$stateCol = updateCol($dir,$stateRow,$stateCol,@pad);
		} elsif ($dir eq 'L') {
			if (($stateCol-1) >= 0 && $pad[$stateRow][($stateCol-1)]) {
				$stateCol--;
			}
		}
	}
	
	push(@code,$pad[$stateRow][$stateCol]);

} # end while loop

close MYFILE;

#print out the code
print "bathroom code is: ";
foreach my $digit (@code) {
	print $digit;
}

print "\n";

exit 0;
#====================== End Main Section =============================
sub updateRow {
	my $d = shift;
	my $r = shift;
	my $c = shift;
	my @p = @_;
	
	if ($d eq 'D') {
		$d = $r + 1;
	} else {
		$d = $r - 1;
	}
	
	if ($p[$d][$c]) {
		return $d;
	} else {
		return $r;
	}
}

sub updateCol {
	my $d = shift;
	my $r = shift;
	my $c = shift;
	my @p = @_;
	
	if ($d eq 'R') {
		$d = $c + 1;
	} else {
		$d = $c - 1;
	}
	
	if ($p[$r][$d]) {
		return $d;
	} else {
		return $c;
	}
}
