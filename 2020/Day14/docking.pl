#!/usr/bin/perl
use warnings;
use strict;

my %mem = ();
my $mask = '';
my $memLoc = 0;
my $total = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	my ($input, $value) = split(' = ');

	if ($input eq 'mask') {
		$mask = $value;
	} else {
		$memLoc = substr($input,4,-1);
		$value = convertValue($mask,$value);
		$mem{$memLoc} = $value;
	}
}

close(INPUT);

foreach my $m (keys (%mem)) {
	print "key is $m, value is now: $mem{$m}\n";
	$total += $mem{$m};
}

print "Sum of all values in Memory: $total\n";

exit(0);
#==========================================================================
sub convertValue {
	my ($m, $val) = @_;

	my $bin = sprintf ("%.36b", $val);

	while(index($m,"X") != -1) {
		my $i = index($m,"X");
		substr($m,$i,1,substr($bin,$i,1));
	}
	
	return oct("0b".$m);
}