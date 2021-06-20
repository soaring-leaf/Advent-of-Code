#!/usr/bin/perl
use warnings;
use strict;

my @instr = ();
my @arg = ();
my @lineCount = ();
my $gVar = 0;
my $pointer = 0;
my $currInstr = "";
my $currVal = 0;
my $trouble = 0;

#open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	($currInstr,$currVal) = split(' ');
	push(@instr,$currInstr);
	push(@arg,$currVal);
	push(@lineCount,0);
}

close(INPUT);

while (!$trouble) {
	if($lineCount[$pointer] == 0) {
		$lineCount[$pointer]++;
		
		if($instr[$pointer] eq 'nop') {
			$pointer++;
		} elsif ($instr[$pointer] eq 'acc') {
			$gVar += $arg[$pointer];
			$pointer++;
		} elsif ($instr[$pointer] eq 'jmp') {
			$pointer += $arg[$pointer];
		} else {
			die "Something went terribly wrong, Instr not found $instr[$pointer] \n";
		}
		
	} else {
		$trouble++;
	}
	
	if($pointer >= scalar(@instr)) {
			print "Hit the end of the code! \n";
			$trouble++;
	}
}

print "Before hitting the Infinite loop, the global var is $gVar.\n";

exit(0);
#==========================================================================
