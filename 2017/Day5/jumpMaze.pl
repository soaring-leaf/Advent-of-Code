#!/usr/local/bin/perl
use warnings;
use strict;

my @instr;
my $pos = 0;
my $nextPos = 0;
my $elmt = 0;
my $steps = 0;
my $exitBool = 0;

open (MYFILE,"<input.txt") or die "Can't open input file: $!";

while(<MYFILE>) {
	chomp($_);
	push(@instr,$_);	
}

close(MYFILE);

while(!$exitBool) {
	$elmt = $instr[$pos];
	
	# Part 1:
	#$instr[$pos]++;
	
	# Part 2:
	if ($elmt > 2) {
		$instr[$pos]--;
	} else {
		$instr[$pos]++;
	}
	
	$nextPos = $pos + $elmt;
	if ( ($nextPos < 0) || ($nextPos >= scalar(@instr)) ) {
		$exitBool++;
	} else {
		$pos = $nextPos;
	}
	
	$steps++;
	
	if ($steps % 1000000 == 0) {
		print "Still working; on step $steps \n";
	}
}

print "It took $steps steps to exit \n";

exit 0;
#====================== End Main Section =============================

