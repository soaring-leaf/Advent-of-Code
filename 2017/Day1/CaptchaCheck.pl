#!/usr/local/bin/perl
use warnings;
use strict;

my $code = '';
my $checkSum = 0;
my $halfLen = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	$code = $_;
}

close MYFILE;

# Part 1 Solution
# =============================================
#$code = $code . substr($code,0,1);

#for (my $i=0;$i< (length($code)-1);$i++) {
#	my $item = substr($code,$i,1);
#	
#	if ( $item eq substr($code,$i+1,1)) {
#		$checkSum = $checkSum + $item;
#	}
#}

# Part 2
# =============================================
$halfLen = length($code)/2;

for (my $i=0;$i<$halfLen*2;$i++) {
	my $item = substr($code,$i,1);
	
	if ($i < $halfLen) {
		if ($item == substr($code,$i+$halfLen,1)) {
			$checkSum = $checkSum + $item;
		}
	} else {
		if ($item == substr($code,$i-$halfLen,1)) {
			$checkSum = $checkSum + $item;
		}
	}
	
}

print "Captcha sum is $checkSum. \n";

exit 0;
#====================== End Main Section =============================

