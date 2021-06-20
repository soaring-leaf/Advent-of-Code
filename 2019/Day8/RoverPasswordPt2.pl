#!/usr/bin/perl
use warnings;
use strict;

my $file = 0;
my @layered;
my @image;
my $i=0;

open(INPUT,"<input.txt") or die "Unable to open input.txt: $!";

while(<INPUT>) {
	$file = $_;
	#print "length of image file is: ".length($image)."\n";
}

close(INPUT);

while($i < length($file)) {
	my $seg = substr($file,$i,150);	# get the next layer
	
	# build the Layered Image
	my @L = split('',$seg);
	push(@layered,\@L);
	
	$i += 150;
}

for(my $k=0;$k<150;$k++) {
	for(my $m=0;$m<100;$m++) {
		if($layered[$k][$m] == 2) {
			$image[($k-($k%25)/25][($k%25)] = 'X'; ###STILL NEED TO FIGURE THIS OUT!!!
			$m=200;
		}
		if($m == 149) {
			$image[($k%6)][($k-($k%25))/25)] = '.';
		}
	}
}



exit(0);
#==========================================================================
