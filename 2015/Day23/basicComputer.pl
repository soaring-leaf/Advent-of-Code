#!usr/local/bin/perl
use strict;
use warnings;

my @instrs;
my $a = 1;
my $b = 0;
my $index = 0;
my $step;
my $item;
my $num;

open(MYFILE,"<input.txt") or die "unable to open file: $!";

while (<MYFILE>) {
	chomp($_);
	$_ = trim($_);
	
	push(@instrs,$_);	
}

while ($index  != scalar(@instrs)) {
	$step = $instrs[$index];
	($item, $step) = split(' ',$step,2);
	
	if ($item eq 'inc') {
		if ($step eq 'a') {
			$a++;
		} else {
			$b++;
		}
		$index++;		
	} elsif ($item eq 'tpl') {
		$a = $a * 3;
		$index++;
	} elsif ($item eq 'hlf') {
		$a = int($a/2);
		$index++;
	} elsif ($item eq 'jmp') {
		#$step = substr($step,1);
		$index = $index + $step;
	} elsif ($item eq 'jio') {
		($step, $num) = split(',',$step);
		$num = trim($num);
		$num = substr($num,1);
		if ($a == 1) {
			$index = $index + $num;
		} else {
			$index++;
		}
	} elsif ($item eq 'jie') {
		($step, $num) = split(',',$step);
		$num = trim($num);
		$num = substr($num,1);
		if (($a % 2) == 0 ) {
			$index = $index + $num;
		} else {
			$index++;
		}
	} else {
		$index = scalar(@instrs);
	}
	#print "$index ";
	
}

print "\nRegister B is now $b\n";

exit (0);
#====================== End Main Section =============================
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
