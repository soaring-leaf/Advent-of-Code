#!/usr/local/bin/perl
use warnings;
use strict;

my %particles;
my $count = 0;
my $minA = 50;
my $particle = 0;

open(MYFILE,"<input.txt") or die "Can't open Input file $!";

while(<MYFILE>) {
	chomp($_);
	my @line = split('>');
	shift(@line);shift(@line);
	my $acc = substr(shift(@line),5);
	
	@line = split(',',$acc);
	my $totAcc = abs($line[0]) + abs($line[1]) + abs($line[2]);
	if($totAcc < $minA) {
		$particle = $count;
		$minA = $totAcc;
	}

}

close(MYFILE);

print "Particle moving slowest is $particle\n with $minA acceleration/n";

exit 0;
#====================== End Main Section =============================


