#!/usr/local/bin/perl
use warnings;
use strict;

my $poly = '';

open (MYFILE,"<input.txt") or die "Can't open file: $!";

while (<MYFILE>) {
	$poly = $_;
}

close(MYFILE);

# Test Sample:
#$poly = 'dabAcCaCBAcCcaDA';

# Part 1
#=================================

$poly = react($poly);
 
print "Length of original polymer remaining is ".length($poly)." \n";


# Part 2
#=================================
my @alpha = ('a' .. 'z');
my $orig = $poly;
my $min = 10000;
my $offset = 0;
my $c0 = '';

open(MYFILE,">output.txt") or die "Can't create output file: $!";

foreach my $e (@alpha) {
	$poly = $orig;
	$offset = 0;
	
	while($offset < (length($poly) - 1)) {
		$c0 = substr($poly,$offset,1);	
		
		if(lc($c0) eq $e) {
			$poly = substr($poly,0,$offset) . substr($poly,$offset+1);
		} else {
			$offset++;
		}
	 
	}
	
	$poly = react($poly);
	
	print MYFILE "removing $e, Polymer is now $poly\n\n";
	
	if(length($poly) < $min) {
		$min = length($poly);
	}
}

close(MYFILE);

print "Minimum polymer is length: $min \n";

exit 0;
#====================== End Main Section =============================
sub react {
	my $p = $_[0];
	my $off = 0;
	my $c1 = '';
	my $c2 = '';

	while($off < (length($p) - 1)) {
		$c1 = substr($p,$off,1);	
		$c2 = substr($p,$off+1,1);
	 
		if((uc($c1) eq uc($c2)) && ($c1 ne $c2)) {
			$p = substr($p,0,$off) . substr($p,$off+2);
			if($off > 0) {
				$off--;
			}
		} else {
			$off++;
		}
	}
	 
	return $p;
}
