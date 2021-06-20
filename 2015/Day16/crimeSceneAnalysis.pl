#!/usr/local/bin/perl
use warnings;
use strict;

my @items;
my $line;
my $j;
my $rest;
my $sue = 0;
my $isValid = 1;

open(MYFILE,"<input.txt") or die "unable to open file, $!";

while (<MYFILE>)  {
	#print "line is " . $_ . "\n";
	$line = $_;
	chomp($line);
	($j, $sue, $rest) = split(' ',$line,3);
	
	@items = split(',',$rest);
	
	while ( (scalar(@items) > 0) && ($isValid) ) {
		$isValid = checkItem(pop(@items));
	}
	
	if ($isValid) {
		print "sue number $sue gave the gift.\n";
		$isValid = 0;
	} else {
		$isValid = 1;
	}
}

exit 0;
#====================== End Main Section =============================
sub checkItem {
	my $item = trim($_[0]);
	my $num;
	my $v = 0;
	
	($item, $num) = split(' ',$item);
	
	if ( ($item eq 'cats:') && ($num > 7) ) {
		$v = 1;
	} elsif ( ($item eq 'goldfish:') && ($num < 5) ){
		$v = 1;
	} elsif ( ($item eq 'children:') && ($num eq '3') ){
		$v = 1;
	} elsif ( ($item eq 'pomeranians:') && ($num < 3) ) {
		$v = 1;
	} elsif ( ($item eq 'trees:') && ($num > 3) ) {
		$v = 1;
	} elsif ( (($item eq 'samoyeds:') || ($item eq 'cars:')) && ($num eq '2') ) {
		$v = 1;
	} elsif ( ($item eq 'perfumes:') && ($num eq '1') ) {
		$v = 1;
	} elsif ( (($item eq 'akitas:') || ($item eq 'vizslas:')) && ($num eq '0') ) {
		$v = 1;
	}
	
	return $v;
}

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
