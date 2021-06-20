#!/usr/bin/perl
use warnings;
use strict;

my @data = ();
my @preamble = ();
my $currNum = 0;
my $num1 = 0;
my $num2 = 0;
my $runTotal = 0;
my $found = 0;
my $max = 0;
my $min = -1;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	
	push(@data,$_);
	if ($currNum < 25) {
		push(@preamble,$_);	
	}
	
	$currNum++;
}

close(INPUT);

print "Data Stream is $currNum numbers long.\n";

$currNum = 25;

while (!$found) {
	
	# assume this is the one
	$found++;
	
	# run through the Preamble to see if we can find two numbers that sum to current number
	for (my $i=0;$i<24;$i++) {
		for (my $k=$i+1;$k<25;$k++) {
			if (($preamble[$i] + $preamble[$k]) == $data[$currNum]) {
				# if found, revert $found to try the next number
				$found--;
				
				# update preamble
				push(@preamble,$data[$currNum]);
				shift(@preamble);
				
				# advance position in the Data
				$currNum++;
				
				# break the loops
				$k = 25;
				$i = 25;
			} # end if/check
		} # end inner loop
	} # end outer loop
	
}

print "Value that doesn't match in the Preamble is $data[$currNum].\n";

$found = 0;

while (!$found) {
	$runTotal = $data[$num1];
	$num2 = $num1 + 1;
	
	if ($data[$num1] < $data[$num2]) {
		$max = $data[$num2];
		$min = $data[$num1];
	} else {
		$max = $data[$num1];
		$min = $data[$num2];
	}
	
	for (my $i=$num2;$runTotal<$data[$currNum];$i++) {
		$runTotal += $data[$i];
		
		if ($data[$i] < $min) {
			$min = $data[$i];
		}
		
		if ($data[$i] > $max) {
			$max = $data[$i];
		}
		
		if ($runTotal == $data[$currNum]) {
			$found++;
			$num2 = $i;
			$i = $currNum;
		} 
	}
	
	if (!$found) {
		$num1++;
	}
		
}

print "Numbers are $max and $min \n";

$runTotal = $max + $min;

print "Encryption weakness is $runTotal \n";

exit(0);
#==========================================================================
