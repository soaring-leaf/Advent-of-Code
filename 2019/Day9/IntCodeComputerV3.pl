#!/usr/bin/perl
use warnings;
use strict;

my @initMem;

# Part1 - BOOST Test
#my $input = 1;
# Part2 - Thermal Radiators
my $input = 1;
my $output = 0;

#open(INPUT,"<","testInput.txt") or die "Can't open Input.txt $!";
open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
	@initMem = split(',',$_);
}

close(INPUT);

$output = runProgram($input,\@initMem);
		
exit(0);
#==========================================================================
# Execute the IntCode program based on the memory provided
sub runProgram {
	my $isContinue = 1; # Run Computer until Halt found
	my $pos1 = 0;		# Value at Position 1 of Memory
	my $pos2 = 0;		# Value at Position 2 of Memory
	my $res = 0;		# Position in Memory to Save result from Calc
	my $r = 0;			# Result of Calc from OpCode
	my $i = 0;			# Current active Memory Index
	my $in = shift(@_);	# Input
	my $steps = 0;
	my @m = @{$_[0]};
	
	my $opCode = 0;		# Operation to take place for current step
	my $mode1 = 0;		# Parameter Modes 1 to 3
	my $mode2 = 0;
	my $mode3 = 0;
	my $rBase = 0;		# Relative Base starts at 0	

	while($isContinue) {
		# Reset Parameter modes
		$mode1 = 0;
		$mode2 = 0;
		$mode3 = 0;

		# get OpCode
		if($m[$i] < 100) {
			$opCode = $m[$i];
			# no Prameter modes = everything 0 = Position Mode
		} else {
			$opCode = substr($m[$i],-2);
		}
		
		# get Parameter Modes if any
		if($m[$i] > 9999) {
			$mode3 = substr($m[$i],0,1);
			$mode2 = substr($m[$i],1,1);
			$mode1 = substr($m[$i],2,1);
		} elsif ($m[$i] > 999) {
			$mode2 = substr($m[$i],0,1);
			$mode1 = substr($m[$i],1,1);
		} elsif ($m[$i] > 99) {
			$mode1 = substr($m[$i],0,1);
		}
		
#		print "step $steps: modes are 1: $mode1; 2: $mode2; 3: $mode3\n";
		
		if ($opCode == 99) {	# Halt condition
			$isContinue = 0;
		} else {
			$pos1 = $m[($i+1)];
			$pos2 = $m[($i+2)];
			$res = $m[($i+3)];
			
#			print "Current value at Mem[0] = $m[0] and Mem[225] = $m[225]\n";
#			print "\t parameters are: $pos1 and $pos2\n";
			
			# Adjust values if needed based on Mode Parameters
			if($mode1 == 0) {
				$pos1 = $m[$pos1];
			} elsif ($mode1 == 2) {
				print "step $steps - Mode 2 active: prog Val: $m[$i+1]; Position Val: $pos1\n";
				$pos1 = $m[($pos1+$rBase)]; # NEED TO RECONCILE  THIS WITH WHY IT NEEDS TO BE 
											# ADJUSTED IN OPCODE 3
				print "step $steps - Mode 2 active: prog Val: $m[$i+1]; Position Val: $pos1\n";
			}
			
			if($mode2 == 0) {
				$pos2 = $m[$pos2];
			} elsif ($mode2 == 2) {
				$pos2 = $m[($pos2+$rBase)];
			}			
			
			#NEED TO ADD MODE 3
			
#			print "\t parameters are: $pos1 and $pos2\n";
			
			if($opCode == 1) { # Adds Parameters
				$r = $pos1 + $pos2;
				$m[$res] = $r;
				$i += 4;
			} elsif ($opCode == 2) { # Multiplies Parameters
				$r = $pos1 * $pos2;
				$m[$res] = $r;
				$i += 4;
			} elsif ($opCode == 3) { # Save Input to Memory slot
				if ($mode1 == 2) {
					$pos1 = $m[($i+1)] + $rBase;
				}
				$m[$pos1] = $in;
				print "mode: $mode1; prog Val: $m[$i+1]; Position Val: $pos1\n";
				$i += 2;
			} elsif ($opCode == 4) { # Display Output 
				$i += 2;
				
				if($m[$i] == 99) {
					print "Diagnostic Code: $pos1\n";
				} else {
					print "Output: $pos1 at step $steps\n";
				}				
			} elsif ($opCode == 5) { # Jump-if-True
				if($pos1) { # if Parameter 1 is non-zero, jump to value in $pos2
					$i = $pos2;
				} else {
					$i += 3;
				}
			} elsif ($opCode == 6) { # Jump-if-False
				if($pos1) { # if Parameter 1 is zero (false), jump to value in $pos2
					$i += 3;
				} else {
					$i = $pos2;
				}
			} elsif ($opCode == 7) { # Less Than
				if($pos1 < $pos2) { # if Parameter 1 is less than Param 2, stores 1 otherwise 0
					$m[$res] = 1;					
				} else {
					$m[$res] = 0;
				}
				$i += 4;
			} elsif ($opCode == 8) { # Equals
				if($pos1 == $pos2) { # if Parameter 1 is equal to Param 2, stores 1 otherwise 0
					$m[$res] = 1;					
				} else {
					$m[$res] = 0;
				}
				$i += 4;
			} elsif ($opCode == 9) { # Adjust Relative Base value
				$rBase += $pos1;
				print "Rel Base is now $rBase at step $steps\n";
				$i += 2;
			} else { # Unknown OpCode
				print "Something went terribly wrong! OpCode read was $m[$i] => $opCode at step $steps\n";
				$isContinue = 0;
			}
		}
		$steps++;
	}

	return $m[0];
}