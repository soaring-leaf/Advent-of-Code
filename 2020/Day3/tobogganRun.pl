#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

my @map = ();
my $dist = -1;
my $len = 0;
my $trees = 0;
my $r = 0;
my $c = 0;
my @traverse = (1,1,3,5,7);
my $results = 1;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	$len = length($_);
	my @scan = split('');
	push(@map,\@scan);
	$dist++;
}

close(INPUT);

#print Dumper \@map;
#print "\n\n";

print "Map is $len wide and $dist long\n";

for (my $i=0;$i<5;$i++) {
	$trees = 0;
	$r = 0;
	$c = 0;
	
	while ($r <= $dist) {
		#print "checking ($r, $c) which has " . $map[$r][$c] . "\n";
		if($map[$r][$c] eq '#') {
			$trees++;
		}
		if ($i == 1) {
			$r += 2;
		} else {
			$r++;
		}
		$c = ($c + $traverse[$i]) % $len;
	}
	$results *= $trees;
	print "Encountered $trees for slope $i check.\n";
}

# Part 1 is just checking the one toboggan slope of Right 3, down 1
#print "Starting at (0,0), I'd hit $trees trees\n";

print "Factor of all trees encountered is $results\n";

exit(0);
#==========================================================================
