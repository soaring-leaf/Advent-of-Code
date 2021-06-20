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
	my $state = 0; #outside brackets = 0, inside brackets = 1;
	my $good = 0;
	my @in;
	my %out;
	my $str = '';
	
	for (my $i=0;$i<(scalar(@ip)-2);$i++) {
		if ($ip[$i] eq '[') {
			$state = 1;
		}
		
		if ($ip[$i] eq ']') {
			$state = 0;
		}
		
		if (($ip[$i] eq $ip[$i+2]) && ($ip[$i] ne $ip[$i+1]) && (($ip[$i+1] ne '[') || ($ip[$i+1] ne ']'))) {
			if ($state) {
				$str = join('',$ip[$i],$ip[$i+1],$ip[$i+2]);
				$out{$str} = 1;
			} else {
				push(@in,join('',$ip[$i],$ip[$i+1],$ip[$i+2]));
			}
		}
		
	} # end for loop
	
	$good = compareSets(\@in,\%out);
	
	return $good;
}

sub compareSets {
	my @a = @{$_[0]};
	my $h = $_[1];
	my $s = '';
	
	foreach my $e (@a) {
		$s = join('',substr($e,1,1),substr($e,0,1),substr($e,1,1));
		
		if (exists($h->{$s})) {
			return 1;
		}
	}
	
	return 0;
}
	
