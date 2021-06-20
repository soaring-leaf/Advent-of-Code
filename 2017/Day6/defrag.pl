#!/usr/local/bin/perl
use warnings;
use strict;

my @memory;
my @seen;
my $steps = 0;
my $newMem = '';
my $pos = 0;
my $keepLooking = 1;
my $loopStart = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	@memory = split("\t");
}

close MYFILE;

# Add the initial config to the known configs
$newMem = join(' ',@memory);
push(@seen,$newMem);

# Need a loop here to go until a config matches a known config
while($keepLooking) {
	$pos = findMaxPos(\@memory);
	@memory = redistribute(\@memory,$pos); # redistributes the blocks at the location ID'd by $pos
	$newMem = join(' ',@memory);
	($keepLooking, $loopStart) = repitCheck(\@seen,$newMem); # Checks to see if new Config is known, returns bool
	
	if ($keepLooking) {
		push(@seen,$newMem);
		if ($steps % 3000 == 0) {
			print "Still working, on step $steps\n";
		}
	}
	
	#print "$steps config is $newMem; keepLooking is $keepLooking\n";
	$steps++;
} # End While

print "Found at position $loopStart, loop is " . scalar(@seen)-$loopStart . " steps long\n";
print "Number of steps before repetition: $steps \n";

exit 0;
#====================== End Main Section =============================

# Find and return the position of the memory with the most blocks
sub findMaxPos {
	my @m = @{$_[0]};
	my $max = 0;
	my $maxP = 0;
	
	for(my $i=0;$i<scalar(@m);$i++) {
		if ($m[$i] > $max) {
			$max = $m[$i];
			$maxP = $i;
		}
	}
			
	return($maxP);
} # End findMaxPos

# Redistribution of the memory blocks at a given position
sub redistribute {
	(my $aRef, my $p) = @_;
	my @a = @{$aRef};
	my $num = $a[$p];
	
	$a[$p] = 0;
	
	while ($num > 0) {
		$p++;
		
		if ($p == scalar(@a)) {
			$p = 0;
		}
		
		$a[$p]++;
		$num--;		
	} # End while loop
	
	return(@a);	
} # End redistribute

# Check the known configs for repetition. 
# If a config is found return False to stop checking otherwise True
sub repitCheck {
	my @p = @{$_[0]};
	my $s = $_[1];
	
	for(my $i=0;$i<(scalar(@p));$i++) {
		if($p[$i] eq $s) {
			print "found at memory $i\n";
			return(0,$i);
		}
	} # End for loop
	
	return(1,0);
}
