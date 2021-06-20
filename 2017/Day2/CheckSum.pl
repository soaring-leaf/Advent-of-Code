#!/usr/local/bin/perl
use warnings;
use strict;

my $sheet = '';
my $checkSum = 0;
my @items;



open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	$sheet = $_;
	@items = split("\t",$sheet);
# 	Part 1:
#	$checkSum = $checkSum + checkSheet(\@items);

	$checkSum = $checkSum + findDivisors(\@items);
}

close MYFILE;

print "Captcha sum is $checkSum. \n";

exit 0;
#====================== End Main Section =============================

# Finds the Max and Min numbers in the array and returns the difference
sub checkSheet {
	my @s = @{$_[0]};
	my $max = $s[0];
	my $min = $s[0];
	
	for(my $i=1;$i<scalar(@s);$i++) {
		if ($s[$i] < $min) {
			$min = $s[$i];
		}
		if ($s[$i] > $max) {
			$max = $s[$i];
		}
	}
	
return ($max - $min);
} # End checkSheet

# Find the divisors and return the result
sub findDivisors {
	my @a = @{$_[0]};
	
	for(my $i=0;$i<scalar(@a);$i++) {
		for(my $c=0;$c<scalar(@a);$c++) {
			if ($i == $c) {  
				# do nothing
			} elsif ($a[$i] % $a[$c] == 0) {
				return ($a[$i] / $a[$c]);
			} elsif ($a[$i] % $a[$c] == 0) {
				return ($a[$i] / $a[$c]);
			}
		} # end inner For
	} # end outer For
	
	print "if you are reading this, something bad happend /n";
	
} # End findDivisors
