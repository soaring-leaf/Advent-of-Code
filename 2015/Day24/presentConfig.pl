#!/usr/local/bin/perl
use warnings;
use strict;

my $sum = 0;
my @packages;

open(MYFILE,"<input.txt") or die "can't open input file: $!";

while (<MYFILE>) {
	chomp($_);
	$sum = $sum + $_;
	unshift(@packages,$_);
}

print "sum of all presents is $sum and each pile should be ".($sum/3)."\n";

exit 0;

