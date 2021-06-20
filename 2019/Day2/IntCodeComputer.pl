#!/usr/bin/perl
use warnings;
use strict;

my @memory;
my @initMem;
my $result = 19690720;
my $output = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
	@initMem = split(',',$_);
}

close(INPUT);

# Part 1 - adjust memory to "1202 Program Alarm" state
#$memory[1] = 12;
#$memory[2] = 2;

#$output = runProgram(\@memory);

#print "Value at position 0 is now $output \n";

# Part 2 - Find values that produce desired Result in output
for(my $k=0;$k<100;$k++) {
	for(my $n=0;$n<100;$n++) {
		@memory = @initMem;
		$memory[1] = $k;
		$memory[2] = $n;
		$output = runProgram(\@memory);
		
		if($output == $result) {
			print "Values that produce the desired output are $k and $n \n";
			$k = 101;
			$n = 101;
		}
	}
	if ($k == 100) {
		print "something went wrong; did not find desired output \n";
	}
}

exit(0);
#==========================================================================
# Execute the IntCode program based on the memory provided
sub runProgram {
	my $isContinue = 1;
	my $pos1 = 0;
	my $pos2 = 0;
	my $res = 0;
	my $r = 0;
	my $i = 0;
	my @m = @{$_[0]};

	while($isContinue) {
		if ($m[$i] == 99) {	# Halt condition
			$isContinue = 0;
		} else {
			$pos1 = $m[($i+1)];
			$pos2 = $m[($i+2)];
			$res = $m[($i+3)];
			if($m[$i] == 1) { # Add next two memory slots
				$r = $m[$pos1] + $m[$pos2];
				$m[$res] = $r;
				$i += 4;
			} elsif ($m[$i] == 2) { # Multiply next two memory slots
				$r = $m[$pos1] * $m[$pos2];
				$m[$res] = $r;
				$i += 4;
			} else { # Unknown OpCode
				print "Something went terribly wrong! OpCode read was $m[$i] \n";
				$isContinue = 0;
			}
		}
	}

	return $m[0];
}