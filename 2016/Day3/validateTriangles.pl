#!/usr/local/bin/perl
use warnings;
use strict;

my $str = '';
my @sides;
my $L = 1;
my @t1;
my @t2;
my @t3;
my $counter = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	$str = trim($_);
	@sides = split(" ",$str);
	
	push(@t1,$sides[0]);
	push(@t2,$sides[1]);
	push(@t3,$sides[2]);
	
	if ($L == 3) {
		$counter = $counter + validateTriangle(@t1);
		$counter = $counter+ validateTriangle(@t2);
		$counter = $counter + validateTriangle(@t3);
		@t1 = ();
		@t2 = ();
		@t3 = ();
		$L = $L - 3;
	}
	
	$L++;
} # end while loop

close MYFILE;

print  "number of valid triangles is $counter\n";

exit 0;
#====================== End Main Section =============================
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub validateTriangle {
	my $s1 = shift;
	my $s2 = shift;
	my $s3 = shift;
	
	if ( (($s1+$s2) > $s3) && (($s1+$s3) > $s2) && (($s2+$s3) > $s1) ) {
		return 1;
	} else {
		return 0;
	}
}

