#!usr/local/bin/perl
use warnings;
use strict;

my $div = 33554393;
my $mult = 252533;
my $code = 20151125;
my $row = 2;
my $col = 1;

while (!(($row == 2947) && ($col == 3029)) ) {
	$code = calcNext($code,$mult,$div);
	
	if ($row == 1) {
		$row = $col + 1;
		$col = 1;
	} else {
		$row--;
		$col++;
	}
		
}

$code = calcNext($code,$mult,$div);

print "at $row, $col the code is $code\n";

exit (0);
#====================== End Main Section =============================
sub calcNext {
	my ($c, $m, $d) = @_;
	my $num = 0;
	
	$num = $c * $m;
	$num = $num % $d;
	
	return $num;
}
