#!/usr/local/bin/perl
use warnings;
use strict;

my $xPos = -12;
my $yPos = 12;
my %nodeMap;
my $infectCount = 0;
my $dir = 0; # direction facing: U=0, 1=R, 2=D, 3=L
my $steps = 0;
my $node = '';

open(MYFILE,"<input.txt") or die "Can't open Input file $!";

while(<MYFILE>) {
	chomp($_);
	my @line = split('');
	
	foreach my $e (@line) {
		$nodeMap{join(',',$xPos,$yPos)} = $e;
		$xPos++;
	}
		
	$xPos = -12;
	$yPos--;
}

close(MYFILE);

$xPos = 0;
$yPos = 0;

while($steps < 10000) {
	$steps++;
	$node = join(',',$xPos,$yPos);
	
	if($nodeMap{$node} eq '#') {
		$dir = ($dir + 1) % 4;
		$nodeMap{$node} = '.';
	} else {
		$dir = ($dir + 3) % 4;
		$nodeMap{$node} = '#';
		$infectCount++;
	}
	
	if($dir == 0) {
		$yPos++;
	} elsif($dir == 1) {
		$xPos++;
	} elsif($dir == 2) {
		$yPos--;
	} else {
		$xPos--;
	}
	
	$node = join(',',$xPos,$yPos);
	if(!exists($nodeMap{$node})) {
		$nodeMap{$node} = '.';
	}
}

print "After 10,000 bursts there have been $infectCount infections\n";
	
exit 0;
#====================== End Main Section =============================


