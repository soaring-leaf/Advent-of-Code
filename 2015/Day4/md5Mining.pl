#!/usr/local/bin/perl
use warnings;
use strict;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use bignum qw/hex/;
use Scalar::Util;

my $found = 0;		# Is mining successful finding '00000' at start of hash
my $mdString = 0;	# Code to put through MD5
my $counter = 0;	# Number to add to end of code
my $hash = 0;		# MD5 result
my $code = 'iwrupvqb';	# secret code

while (!$found) {
	
	$counter++;	
	
	$mdString = $code . $counter;
	
	$hash = md5_hex($mdString);
	
	$found = checkHash($hash);
	
	stillWorking($counter);
	
#	print "mdString: $mdString; hash: $hash; \n";
	
#	if ($counter > 609045) {
#		$found = 1;
#	}
	
} # end while loop

print "Successful mining operation at $counter. \n";

exit 0;
#====================== End Main Section =============================
sub stillWorking {
	my $n = $_[0];
	
	if (($n % 50000) == 0) {
		print "Still working; On the $n" . "th iteration. \n";
	}
}

sub checkHash {
	my $h = $_[0];
	my $nums = substr($hash,0,5);
	
	#print "nums: $nums. \n";
	
	if ($nums eq '00000') {
		return 1;
	} else {
		return 0;
	}
	
} #end getHash