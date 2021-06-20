#!/usr/local/bin/perl
use warnings;
use strict;

my $fileName = 'input.txt';
my $l = 0;
my $h = 0;
my $w = 0;
my $extra = 0;
my $max = 0;
my $paperTotal = 0;
my $boxArea = 0;
my $volume = 0;
my $ribbonTotal = 0;
my $ribbonLen = 0;

#open (MYFILE,"<test.txt") or die "Couldn't open file, $!";
open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	($l,$w,$h) = split('x',$_);
	$max = findmaxD($l,$w,$h);
	($boxArea,$volume) = getBoxProperties($l,$w,$h);
	
	if ($max eq $l) { 
		$extra = getSlack($w,$h); 
		$ribbonLen = getRibbonLen($w,$h);
	} elsif ($max eq $w)	{ 
		$extra = getSlack($l,$h); 
		$ribbonLen = getRibbonLen($l,$h);
	} else { 
		$extra = getSlack($w,$l); 
		$ribbonLen = getRibbonLen($w,$l);
	}
	
	$paperTotal = $paperTotal + $boxArea + $extra;
	$ribbonTotal = $ribbonTotal + $volume + $ribbonLen;
	
	#print "area is $boxArea, largest dimention is $max, extra is $extra\n";
} # end while loop

	print "Total sq feet of paper needed is $paperTotal. \n";
	print "Total length of ribbon needed is $ribbonTotal feet.";
	
close MYFILE;

exit 0;
#====================== End Main Section =============================
sub getRibbonLen {
	my ($dim1, $dim2) = @_;

	return ( (2*$dim1) + (2*$dim2) );	
}

sub getSlack {
	my ($dim1, $dim2) = @_;

	return ($dim1*$dim2);	
}

sub getBoxProperties {
	my ($len, $wdth, $hgt) = @_;
	my $a = 2*($len*$wdth + $len*$hgt + $wdth*$hgt);
	my $v = $len*$wdth*$hgt;
	
	return ($a, $v);
}

sub findmaxD {
	my $m = $_[0];

	if ($m < $_[1]) {
		$m = $_[1];
	}
	
	if ($m < $_[2]) {
		$m = $_[2];
	}
	
	return $m;
}
