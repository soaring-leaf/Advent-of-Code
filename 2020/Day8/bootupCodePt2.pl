#!/usr/bin/perl
use warnings;
use strict;

my @instr = (); 	# Code Instructions
my @arg = ();		# corresponding Values for Instr
my @lineCount = (); # Number of times line of code has run
my $gVar = 0;		# Global Variable
my $pointer = 0;	# position while checking code
my $currInstr = "";	# Initializing @instr
my $currVal = 0;	# Initializing @arg
my $finished = 0;	# Code completed flag

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	($currInstr,$currVal) = split(' ');
	push(@instr,$currInstr);
	push(@arg,$currVal);
	push(@lineCount,0);
}

close(INPUT);

while (!$finished) {
	# update next nop or jmp to break infinite loop
	for (my $i = $pointer;$i<scalar(@instr);$i++) {
		if ($instr[$i] eq 'nop') {
			$instr[$i] = 'jmp';
			$pointer = $i;
			$i = scalar(@instr);
		} elsif ($instr[$i] eq 'jmp') {
			$instr[$i] = 'nop';
			$pointer = $i;
			$i = scalar(@instr);
		}
	}
	
	($finished,$gVar) = runCode(\@instr,\@arg,\@lineCount);
	
	#restore changed instruction if program looped
	if (!$finished) {
		if ($instr[$pointer] eq 'nop') {
			$instr[$pointer] = 'jmp';
		} else {
			$instr[$pointer] = 'nop';
		}
		$pointer++; # advance pointer to next instruction
	}
	#$finished = 1; #preventing infinite loop for testing
}

print "At the end of the code, the global var is $gVar.\n";

exit(0);
#==========================================================================
sub runCode {
	my @oper = @{$_[0]};
	my @vals = @{$_[1]};
	my @iCount = @{$_[2]};
	my $looped = 0;
	my $finished = 0;
	my $p = 0;
	my $value = 0;
	
	while (!$looped && !$finished) {
		if ($iCount[$p] == 0) {
			$iCount[$p]++;
			
			if ($oper[$p] eq 'nop') {
				$p++;
			} elsif ($oper[$p] eq 'acc') {
				$value += $vals[$p];
				$p++;
			} elsif ($oper[$p] eq 'jmp') {
				$p += $vals[$p];
			} else {
				die "Something went terribly wrong, Instr not found $oper[$p] \n";
			}
			
		} else {
			$looped++;
		}
		
		if ($p >= scalar(@oper)) {
				print "Hit the end of the code! \n";
				$finished++;
		}
	}
	
	# return True (1) if finished or False (0) if not and the Global Variable value
	return($finished,$value); 
}