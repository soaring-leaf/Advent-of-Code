#!/usr/local/bin/perl
use warnings;
use strict;

my $a = 0;
my $b = 0;
my $c = 1;
my $d = 0;
my @instr;
my @step;
my $i = 0;

open (MYFILE,"<input.txt") or die "unable to open file: $!";

while (<MYFILE>) {
	chomp($_);
	push(@instr,$_);
}

close(MYFILE);

while ($i < scalar(@instr)) {
	@step = split(' ',$instr[$i]);
	
	if ($step[0] eq 'inc') {
		if ($step[1] eq 'a') {
			$a++;
		} elsif ($step[1] eq 'b') {
			$b++;
			} elsif ($step[1] eq 'c') {
			$c++;
		} else {
			$d++;
		} 
		$i++;
	} elsif ($step[0] eq 'dec') {
		if ($step[1] eq 'a') {
			$a--;
		} elsif ($step[1] eq 'b') {
			$b--;
			} elsif ($step[1] eq 'c') {
			$c--;
		} else {
			$d--;
		} 
		$i++;
	} elsif ($step[0] eq 'cpy') {
		if ($step[2] eq 'a') {
			$a = getValue($a,$b,$c,$d,$step[1]);
		} elsif ($step[2] eq 'b') {
			$b = getValue($a,$b,$c,$d,$step[1]);
			} elsif ($step[2] eq 'c') {
			$c = getValue($a,$b,$c,$d,$step[1]);
		} else {
			$d = getValue($a,$b,$c,$d,$step[1]);
		} 
		$i++;
	} else {
		if (getValue($a,$b,$c,$d,$step[1]) ne 0) {
			$i = $i + $step[2];
		} else {
			$i++;
		}
	}
}

print "Register A is now $a \n";

exit(0);
#====================== End Main Section =============================
sub getValue {
	my $a = shift;
	my $b = shift;
	my $c = shift;
	my $d = shift;
	my $i = shift;
	
	if ($i eq 'a') {
		return $a;
	} elsif ($i eq 'b') {
		return $b;
	} elsif ($i eq 'c') {
		return $c;
	} elsif ($i eq 'd') {
		return $d;
	} else {
		return $i;
	}
}
