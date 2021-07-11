#!/usr/bin/perl
use warnings;
use strict;

my %mem = ();
my $mask = '';
my $memLoc = 0;
my $total = 0;

#open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	(my $input, my $value) = split(' = ');

	if ($input eq 'mask') {
		$mask = $value;
	} else {
		$memLoc = substr($input,4,-1);
		$mem{$memLoc} = $value;
	}
}

close(INPUT);

foreach my $m (keys (%mem)) {
	print "key is $m\n";
	$total += $mem{$m};
}

print "Sum of all values in Memory: $total\n";

exit(0);
#==========================================================================
