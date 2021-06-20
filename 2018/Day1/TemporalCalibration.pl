#!/usr/local/bin/perl
use warnings;
use strict;

my $Hz = 0;
my %list = (0 => 0);
my $found = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

# Part 1
#=================================

while (<MYFILE>) {
	chomp;
	$Hz += $_;
}

print "Final Frequency on first walkthrough is $Hz. \n";

close(MYFILE);

# Part 2
#=================================

my $Hz2 = 0;
my $first = -1;
my $c = 0;

while (!$found) {
	open (MYFILE,"<input.txt") or die "Can't open file, $!";
	$c++;
	
while (<MYFILE>) {
	chomp;
	$Hz2 += $_;
	
	if(!$found) {
		if(exists($list{$Hz2})){
			$first = $Hz2;
			$found++;
		} else {
			$list{$Hz2} = $Hz2;
		}
	}
}


close MYFILE;
}

print "First Hz to be duplicated is $first on iteration $c.\n";

exit 0;
#====================== End Main Section =============================

