#!/usr/local/bin/perl
use warnings;
use strict;

my @floor;
my $line = '';
my $last = '';
my $tile = 0;
my $len = 0;
my $safe = 0;

open(MYFILE,"<input.txt") or die "unable to open file: $!";

while (<MYFILE>) {
	chomp($_);
	$last = $_;
	$len = length($last);
	for (my $i=0;$i<$len;$i++) {
		if (substr($last,$i,1) eq '.') {
			$safe++;
		}
	}
}

close(MYFILE);

# initalize the rest of the floor plan (40 rows of tiles)
for (my $r=1;$r<400000;$r++) {
	if ($r % 50000 == 0) {
		print "analyzing row $r\n";
	}
	for (my $i=0;$i<$len;$i++) {
		if ($i == 0) {
			$tile = '.'.substr($last,$i,1).substr($last,($i+1),1);
		} elsif ($i == ($len-1)) {
			$tile = substr($last,($i-1),1).substr($last,$i,1).'.';
		} else {
			$tile = substr($last,($i-1),1).substr($last,$i,1).substr($last,($i+1),1);
		}
					
		if (tileCheck($tile)) {
			# If check is true, then it's a trap
			$line = $line.'^';
		} else {
			# else it's not a trap
			$line = $line.'.';
			$safe++;
		}
	}
	
	$last = $line;
	$line = '';	
}

print "There are $safe safe tiles.\n";	

exit(0);
#====================== End Main Section =============================
sub tileCheck {
	my $s = shift;
	
	if (($s eq '^^.') || ($s eq '.^^') || ($s eq '^..') || ($s eq '..^')) {
		return 1;
	}
	
	return 0;
}
