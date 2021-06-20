#!/usr/local/bin/perl
use warnings;
use strict;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use bignum qw/hex/;
use Scalar::Util;

my $found = 0;		# Is mining successful finding '00000' at start of hash
my $len = 0;		# counts number of successful finds
my $mdString = 0;	# Code to put through MD5
my $counter = -1;	# Number to add to end of salt
my $hash = 0;		# MD5 result
my $salt = 'jlmsuwbz';	# secret code
my %hashSet;

system("del out.txt");
system("echo %TIME%");

while ($len < 64) {
	$counter++;
	
	if (exists $hashSet{$counter}) {
		$hash = $hashSet{$counter};
	} else {
		$hash = getHash($salt,$counter);
	}
	
	$found = processHash($hash,$salt,$counter,\%hashSet);
	
	if ($found) {
		$len++;
	}
	
	stillWorking($counter,$len);

}

close(OUTPUT);

print "index of 64th key is: $counter\n";

system("echo %TIME%");

exit 0;
#====================== End Main Section =============================
sub getHash {
	my $s = shift;
	my $c = shift;
	my $str = $s.$c;
	my $h = '';
	
	$h = md5_hex($str);
	
	for (my $i=0; $i<2016;$i++) {
		$h = md5_hex($h);
	}
	
	return $h;
}

sub stillWorking {
	my $n = shift;
	my $c = shift;
	
	if (($n % 1000) == 0) {
		print "Checking the $n"."th iteration, found $c keys so far.\n";
	}
}

sub processHash {
	my $h = shift;		# current hash
	my $s = shift;		# salt
	my $c = shift;		# counter
	my $hashes = shift;	# ref to hash of hashKeys
	#my @a = split('',$h);
	my $ch = '';
	my $isIt = 0;
	my $len = length($h);
	
	open(OUTPUT,">>out.txt") or die "can't open output file: $!";

	
	for (my $i=0;$i<($len-2);$i++) {
		$ch = substr($h,$i,1);
		if (($ch eq substr($h,$i+1,1)) && ($ch eq substr($h,$i+2,1))) {
			$isIt = validCheck($ch,$s,$c,$hashes);
			
			if ($isIt) {
				print OUTPUT "hash is $h at index $c\n\n";
				return 1;
			}
			last;
		}
		
	}
	
	close(OUTPUT);
	
	return 0;
}

sub validCheck {
	my $char = shift; # character to find a string of 5 in hash
	my $ch = $char;
	my $s = shift;	  # Salt for getting next hash
	my $c = shift;	  # Counter for hash
	my $hashes = shift;	# ref to hash of hashes
	my $end = $c + 1000; 	# end point of checking for current hash
	my $found = 0;		# was string found?
	my $h = '';		# var to hold next hash to check
	
	$char = $ch.$ch.$ch.$ch.$ch;
	$c++;
	
	for (my $i=$c;$i<=$end;$i++) {
		if (exists($hashes->{$i})) {
			$h = $hashes->{$i};
		} else {
			$h = getHash($s,$i);
			$hashes->{$i} = $h;
		}
		$found = index($h,$char);
		if ($found >= 0) {
			print OUTPUT "found:  $h\n";
			return 1;
		}
	}
	
	return 0;
}