#!/usr/local/bin/perl
use warnings;
use strict;

my $steps = 348; # actual input is 348
my @lock = (0,1);
my $pos = 1;

for(my $i=2;$i<50000000;$i++) {
	$pos = ($pos + $steps) % scalar(@lock);	
	
	if($pos == 0) {
		splice(@lock,$pos+1,0,$i);
	} else {
		push(@lock,$i);
	}
	
	$pos++;
	
	if($i % 1000000 == 0) {
		print "still working, on step $i\n";
	}
	#print join(' ',@lock);
	#print "\n";
}

$pos++;

#print "The value after 2017 is $lock[$pos] \n";

# eases up the amount of memory taken and allows the system to recover faster
for (my $k=0;$k<30000000;$k++) { pop(@lock); }

print "The value after 0 is $lock[1]\n";

@lock = ();

exit 0;
#====================== End Main Section =============================


