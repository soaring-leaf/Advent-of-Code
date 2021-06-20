#!/usr/local/bin/perl
use warnings;
use strict;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use bignum qw/hex/;
use Scalar::Util;

my $found = 0;		# Is mining successful finding '00000' at start of hash
my $pos = 0;
my $len = 0;		# counts number of successful finds
my $mdString = 0;	# Code to put through MD5
my $counter = 20000000;	# Number to add to end of code
my $hash = 0;		# MD5 result
my $code = 'wtnhxymk';	# secret code
my @pswd = ('-','-','-','-','-','-','-','-');

while ($len < 8) {
	$mdString = $code.$counter;
	
	$hash = md5_hex($mdString);
	($pos,$found) = processHash($hash);
	
	if ($found eq '-1') {
		# Do nothing, did not find
	} elsif (($pos < 8) && (($pswd[$pos] eq '-'))) { # || ($pswd[$pos] eq '/') || ($pswd[$pos] eq '|'))) {
		$pswd[$pos] = $found;
		$len++;
		#system('cls');
		#showPswd(@pswd);
	}
	
	#@pswd = stillWorking($counter,@pswd);
	stillWorking($counter);
	$counter++;
}

print "Room Password is:\n";
showPswd(@pswd);

exit 0;
#====================== End Main Section =============================
sub showPswd {
	my @p = @_;
	
	foreach my $e (@p) {
		print "$e ";
	}
	print "\n";	
}

sub stillWorking {
	my $n = shift;
	#my @p = @_;
	
	if (($n % 1000000) == 0) {
		print "Checking the $n" . "th iteration \n";
		#@p = updatePswd(@p);
		#system('cls');
		#showPswd(@p);
	}
	#return (@p);
}

sub updatePswd {
	my @p = @_;
	
	for (my $i=0;$i<8;$i++) {
		if ($p[$i] eq '-') {
			$p[$i] = '/';
		} elsif ($p[$i] eq '/') {
			$p[$i] = '|';
		} elsif ($p[$i] eq '|') {
			$p[$i] = '-';
		}
	}
	return (@p);
}

sub processHash {
	my $check = '00000';
	my $h = shift;
	my $seg = substr($h,0,5);
	
	if ($check eq $seg) {
		print "found one, hash is $h\n";
		return (substr($h,5,1),substr($h,6,1));
	} else {
		return (0,-1);
	}
}