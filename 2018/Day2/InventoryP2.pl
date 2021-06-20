#!/usr/local/bin/perl
use warnings;
use strict;

my %id;
my $count = 0;
my @b1;
my @b2;
my $offBy = 0;
my $commonChars = '';

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

# Part 2
#=================================

while (<MYFILE>) {
	chomp;
	$id{$count} = $_;
	$count++;
}

close(MYFILE);

for(my $i=0;$i<($count-1);$i++) {
	for(my $k=$i+1;$k<$count;$k++) {
		@b1 = split('',$id{$i});
		@b2 = split('',$id{$k});
		for(my $z=0;$z<scalar(@b1);$z++) {
			if($b1[$z] eq $b2[$z]) {
				$commonChars = $commonChars . $b1[$z];
			} elsif ($offBy == 1) {
				$offBy++;
				$z = scalar(@b1);
			} else {
				$offBy++;
			}
		
		}
		if($offBy == 1) {
			$k = $count;
			$i = $count;
		} else {
			$commonChars = '';
			$offBy = 0;
		}
	}
}

print "Common characters between the matching boxes are: $commonChars\n";

exit 0;
#====================== End Main Section =============================

