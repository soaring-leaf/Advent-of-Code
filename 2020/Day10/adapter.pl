#!/usr/bin/perl
use warnings;
use strict;

my @adapters = ();
my $jump1 = 0;
my $jump3 = 0;
my $currJolts = 0;
my $count = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	
	push(@adapters,$_);
	
	$count++;
}

close(INPUT);

print "I've got $count adapters.\n";

@adapters = sort { $a <=> $b } @adapters;

for (my $i=0;$i<scalar(@adapters);$i++) {
	if (($adapters[$i] - $currJolts) == 1) {
		$jump1++;
	} elsif (($adapters[$i] - $currJolts) == 3) {
		$jump3++;
	}
	
	$currJolts = $adapters[$i];
}

# +1 for the Device adapter
$jump3++;

print "Difference Factor is " . ($jump1 * $jump3) . "\n";

#reset for adapter reconfig
$count = 0;

$count = adapterConfig(\@adapters,0);

print "There are $count configurations for these adapters\n";

exit(0);
#==========================================================================
sub adapterConfig {
	my @adapts = @{ $_[0] };	# list of current adapters
	my $pos = $_[1];			# position to start removing adapters
	my $len = scalar(@adapts);	# Length of list
	my $c = 0; 					# number of sub-configs that are valid
	my $currJs = 0;				# Current Jolts for checking
	
	# check if this is a valid Config, return false (0) if not
	# Will never remove last adapter so no need to check to device
	for (my $k=0;$k<$len;$k++) {
		if(($adapts[$k] - $currJs) > 3) {
			return $c;
		} else {
			$currJs = $adapts[$k];
		}
	}
	
	# print the valid config for testing
	#foreach my $e (@adapts) {
	#	print $e . " ";
	#}
	
	#print "\n";
	
	# If made it through checks, then this config is good: +1
	$c++;
	$currJs = 0;
	
	# remove each adapter one at a time and check through again
	# The last adapter is required to connect to device so not removing that one
	for (my $rem=$pos;$rem<($len-1);$rem++) {
		if($len == 112) {
			print "current available configs is $c and we are removing adapter in position $rem\n";
		}
		
		if (($adapts[($rem+1)]-$adapts[($rem-1)]) <= 3) {
			# save jolt value of current adapter being removed
			# Splice is too inefficient and has to happen multiple times
			#my $currAdptr = splice(@adapts,$rem,1); 
			my $currAdptr = $adapts[$rem];
			my @tempList = ();
			
			for (my $e=0;$e<$len;$e++) {
				if ($e != $rem) {
					push(@tempList,$adapts[$e]);
				}
			}
			
			# check new config and possible sub-configs
			$c += adapterConfig(\@tempList,$rem);
			
			# put adapter back into list and check what happens when removing next one
			#splice(@adapts,$rem,0,$currAdptr);
			
		}
	}
		
	# return counts for current config and sub-configs
	return $c;	
}