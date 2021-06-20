#!/usr/local/bin/perl
use warnings;
use strict;

my $disk = 35651584;
my $data = '11011110011011101';
#my $data = '01001';
my $a = 0;
my $b = 0;

while (length($data) < $disk) {
	$a = $data;
	$b = scalar reverse $a;
	$b = updatePt2($b);
	$data = $a.'0'.$b;
	print "length of disk is ".length($data)."\n";
}

$data = substr($data,0,$disk);

#print "length of random data should be $disk and is actually ".length($data)."\n";
#print "data is $data\n";

$a = calcCheckSum($data);

print "\nchecksum is now $a\n";

exit 0;
#====================== End Main Section =============================
sub updatePt2 {
	my $s = shift;
	#my @a = split('',$s);
	my $r = '';
	
	for (my $i=0;$i<length($s);$i++) {
		if (substr($s,$i,1) eq '1') {
			$r = $r.'0';
		} else {
			$r = $r.'1';
		}
	}
	
	return $r;	
}

sub calcCheckSum {
	my $s = shift;
	#my @a = split('',$s);
	my $cSum = '';
	my $cont = 1;
	
	while ($cont) {
		for (my $i=0;$i<length($s);$i=$i+2) {
			if (substr($s,$i,1) eq substr($s,($i+1),1)) {
				$cSum = $cSum.'1';
			} else {
				$cSum = $cSum.'0';
			}
			
		}
		
		if ((length($cSum) % 2) == 0) {
			$s = $cSum;
			$cSum = '';
			#print "calculating checksum $cont\n";
			#print "checksum has length of ".length($s)."and is \n$s\n";
			$cont++;
		} else {
			$s = $cSum;
			$cont = 0;
		}
	}
	
	return $s;
}
