#!/usr/bin/perl
use warnings;
use strict;

my @pWords;
my $matchCnt = 0;
my $valid = 0;
my $min = 0;
my $max = 0;
my $count = 0;
my $pswd = '';
my $ltr = '';
my $range = '';
my $pos1 = '';
my $pos2 = '';

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
	chomp;
	push(@pWords,$_);
}

close(INPUT);

foreach(@pWords) {
	($range,$ltr,$pswd) = split(' ',$_);
	$ltr = substr($ltr,0,1);
	($min,$max) = split('-',$range);
	$min--;
	$max--;

	$pos1 = substr($pswd,$min,1);
	$pos2 = substr($pswd,$max,1);

	if(($pos1 eq $ltr || $pos2 eq $ltr) && $pos1 ne $pos2) {
		$count++;
	}
	
}

print "Found $count valid passwords. \n";

exit(0);
#==========================================================================
