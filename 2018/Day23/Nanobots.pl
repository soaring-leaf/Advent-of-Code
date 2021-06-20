#!/usr/local/bin/perl
use warnings;
use strict;

my $range = 0;
my $pos = '';
my @bots;
my $index = 0;
my $strongest = 0;
my $count = 0;
my $num = 0;

open (MYFILE,"<input.txt") or die "Can't open file: $!";

while (<MYFILE>) {
	chomp;
	($pos,$range) = split(">, r=");
	$pos = substr($pos,5);
	
	if($strongest < $range) {
		$num = $count;
		$strongest = $range;
	}
	
	push(@bots,"$pos,$range");
	$count++;
}

close(MYFILE);

print "the strongest bot, $bots[$num] is at index $num out of $count bots.\n";

# Part 1
#=================================
$count = 0;
my @strongPos = split(",",$bots[$num]);
#$pos = abs($loc[0])+abs($loc[1])+abs($loc[2]);

for(my $i=0;$i<scalar(@bots);$i++) {	
	my @loc = split(",",$bots[$i]);
	
	if((abs($loc[0]-$strongPos[0])+abs($loc[1]-$strongPos[1])+abs($loc[2]-$strongPos[2])) <= $strongest) {
		$count++;
	}	
}

print "There are $count bots within range of the strongest bot\n";

# Part 2
#=================================


exit 0;
#====================== End Main Section =============================

