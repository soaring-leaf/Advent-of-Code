#!/usr/local/bin/perl
use warnings;
use strict;

#my $word = 'hepxcrrq'; # Part 1
my $word = 'hepxxyzz'; # Part 2: expired again, what is next password?
my $isValid = 0;
my $count = 0;

while (!($isValid)) {
	$word++;
	
	if ( (checkBadChars($word)) && (checkPairs($word)) && (checkStraight($word)) ) {
		$isValid = 1;	
	}
	
	if ($count == 300000) {
		$count = 0;
		print "still working, password is now $word\n";
	}
	$count++;
}

print "new password is $word.\n";

exit 0;
#====================== End Main Section =============================
sub checkStraight {
	my $w = $_[0];
	my @str = split('',$w);
	my $L1;
	
	for (my $k=0;$k<(scalar(@str)-2);$k++) {
		$L1 = $str[$k];
		
		$L1++;
		
		if ($L1 eq $str[($k+1)]) {
				$L1++;
			if ($L1 eq $str[($k+2)]) {
				return 1;
			}
		}
	}	

	return 0;
}
sub checkPairs {
	my $w = $_[0];
	my @str = split('',$w);
	my $count = 0;
	
	for (my $k=0;$k<(scalar(@str)-1);$k++) {
		if ($str[$k] eq $str[($k+1)]) {
			$count++;
			$k++;
		}
	}	
	
	if ($count < 2) {
		return 0;
	} else {
		return 1;
	}
	
}
sub checkBadChars {
	my $w = $_[0];
	my @bad = ('i','o','l');
	my $pos = 0;
	
	for (my $i=0;$i<3; $i++) {
		$pos = index($w,$bad[$i]);
		if ($pos != -1) {
			return 0;
		}
	}
	
	return 1;
}
