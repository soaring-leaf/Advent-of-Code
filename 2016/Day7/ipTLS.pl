#!/usr/local/bin/perl
use warnings;
use strict;

my $count = 0;
my $isIt = 0;

open(MYFILE,"<input.txt") or die "Couldn't open file, $!";
open(OUTPUT,">out.txt") or die "couldn't create file, $!";

while (<MYFILE>) {
	chomp($_);
	
	$isIt = processIP($_);
	$count = $count + $isIt;
	
	if ($isIt) {
		#print "Ip is Good and is: \n";
		print OUTPUT $_."\n";
	}
	
} # end while loop

close MYFILE;
close OUTPUT;

print "number of valid IPs is $count \n";

exit 0;
#====================== End Main Section =============================
sub processIP {
	my $s = shift;
	my @ip = split('',$s);
	my $bad = 0;
	my $good = 0;
	
	
	for (my $i=0;$i<(scalar(@ip)-3);$i++) {
		if ($ip[$i] eq '[') {
			$bad = 1;
		}
		
		if ($ip[$i] eq ']') {
			$bad = 0;
		}
		
		if ( ($ip[$i] eq $ip[$i+3]) && ($ip[$i+1] eq $ip[$i+2]) && ($ip[$i] ne $ip[$i+1])) {
			if ($bad) {
				return 0;
			} else {
				$good = 1;
			}
		}
		
	}
	# more than one bracket sometimes, could be string is found in second bracket
	return $good;
}
