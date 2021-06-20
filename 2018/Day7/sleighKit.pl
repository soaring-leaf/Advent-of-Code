#!/usr/local/bin/perl
use warnings;
use strict;

my %preqs;
my %order;
my @avail = ();
my $notFirst = '';
my $seq = '';


foreach my $e ('A' .. 'F') {
	$preqs{$e} = ();
	$order{$e} = ();
}

#open (MYFILE,"<input.txt") or die "Can't open file: $!";
open (MYFILE,"<test.txt") or die "Can't open file: $!";

while (<MYFILE>) {
	chomp;
	my @steps = split(' ');
	
	push(@{$preqs{$steps[7]}},$steps[1]);
	push(@{$order{$steps[1]}},$steps[7]);
	
	if(index($notFirst,$steps[7]) < 0) {
		$notFirst = $notFirst . $steps[7];
	}

}

close(MYFILE);

# Part 1
#=================================
$seq = findFirst($notFirst);
print "first step is $seq\n";

@avail = sort(@{$order{$seq}});




# Part 2
#=================================


exit 0;
#====================== End Main Section =============================
sub findFirst {
	my $s = $_[0];
	
	foreach my $k ('A' .. 'F') {
		if(index($s,$k) < 0) {
			return($k);
		}
	}
}
