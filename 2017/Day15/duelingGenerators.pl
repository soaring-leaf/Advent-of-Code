#!/usr/local/bin/perl
use warnings;
use strict;

my $seedA = 116;
my $seedB = 299;
my $genA = 0;
my $genB = 0;
my $binA = 0;
my $binB = 0;
my $judge = 0;

for(my $c=0;$c<5000000;$c++) {
	$genA = nextVal($seedA,16807,4);
	$genB = nextVal($seedB,48271,8);
	$seedA = $genA;
	$seedB = $genB;
	$binA = sprintf ("%.32b",$genA);
	$binB = sprintf ("%.32b",$genB);
	
#	print "$genA \t\t $genB \n";
#	print "$binA \t $binB \n";
	
	if(substr($binA,-16) eq substr($binB,-16)) {
		$judge++;
	}
	
	if($c % 100000 == 0) {
		print "still working, on try $c. $judge matches so far.\n";
	}
}

print "Judge's count is $judge \n";

exit 0;
#====================== End Main Section =============================

sub nextVal {
	(my $s, my $v, my $c) = @_;
	my $num = 0;
	
	while (1) {
		$num = ($s * $v) % 2147483647;
		if($num % $c == 0) {
			return($num);
		} else {
			$s = $num;
		}
		
	}
}
	
