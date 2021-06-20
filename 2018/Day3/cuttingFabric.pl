#!/usr/local/bin/perl
use warnings;
use strict;

my @claims;
my @offset;
my @range;
my $overlap = 0;
my @fabric; 

for(my $init=0;$init<1000;$init++) {
	push(@fabric,[('.') x 1000]);
}

open (MYFILE,"<input.txt") or die "Can't open file: $!";

while (<MYFILE>) {
	chomp;
	my($junk,$c) = split('@ ');
	push(@claims,$c);
}

close(MYFILE);

# Part 1
#=================================
for(my $i=0;$i<scalar(@claims);$i++) {
	my @holder = split(': ',$claims[$i]);
	@offset = split(',',$holder[0]);
	@range = split('x',$holder[1]);
	
	for(my $xPos=$offset[0];$xPos<($offset[0]+$range[0]);$xPos++) {
		for(my $yPos=$offset[1];$yPos<($offset[1]+$range[1]);$yPos++) {
			if($fabric[$xPos][$yPos] eq '.') {
				$fabric[$xPos][$yPos] = $i+1;
			} else {
				if($fabric[$xPos][$yPos] ne 'M') {
					#Flag for part 2
					$claims[($fabric[$xPos][$yPos])-1] = -1;
				}
				$fabric[$xPos][$yPos] = 'M';
				$claims[$i] = -1;
			}
		}
	}
}

for(my $x=0;$x<1000;$x++) {
	for(my $y=0;$y<1000;$y++) {
		if($fabric[$x][$y] eq 'M') {
			$overlap++;
		}
	}
}

print "$overlap squares overlap multiple claims \n";

# Part 2
#=================================
for(my $k=0;$k<scalar(@claims);$k++) {
	if($claims[$k] ne -1) {
		print "Claim that doesn't overlap is ". ($k+1) ."\n";
		$k = scalar(@claims);
	}
}

exit 0;
#====================== End Main Section =============================

