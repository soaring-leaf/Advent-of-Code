#!/usr/local/bin/perl
use warnings;
use strict;

my @units;
my @used;
my $total = 0;
my $count = 0;

open(MYFILE,"<input.txt") or die "unable to open file: $!";

while (<MYFILE>) {
	chomp($_);
	push(@units,$_);
}

for (my $i=0;$i<scalar(@units);$i++) {
	push(@used,$i);
	$count = getCombos(\@units,\@used,$i);
	$total = $total + $count;
	@used = ();
}

print "total combinations are $total\n";

exit 0;
#====================== End Main Section =============================
sub getCombos {
	my ($orig, $inUse, $curr) = @_;
	my $vol = 0;
	my $cnt = 0;
	
	#check if good total volume
	$vol = getVolume($orig, $inUse);
	
	if ($vol == 150) {
		$cnt++;
		$curr++;
	}
	
	if 
}

sub getVolume {
	my ($o, $u) = @_;
	my $t = 0;
	my @arr = @{$u};
	
	foreach $e (@arr) {
		$t = $t + $o->[$e];
	}
	
	return $t;
}
