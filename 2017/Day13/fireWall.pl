#!/usr/local/bin/perl
use warnings;
use strict;

my %scanner;
my $step;
my $cost = 1;
my $delay = 0;

open(MYFILE,"<input.txt") or die "Can't open input file: $!";

while(<MYFILE>) {
	chomp($_);
	(my $s, my $d) = split(": ");
	$scanner{$s} = $d;
}

close(MYFILE);

while($cost) {
	$delay++;
	$cost = traverse(\%scanner,$delay);
	
	if ($delay % 1000000 == 0) {
		print "still working on the delay, attempt $delay \n";
	}
}

#print "The Severity of the trip is $cost \n";
print "Need to delay $delay pico-seconds to traverse successfully \n";

exit 0;
#====================== End Main Section =============================

# Attempts to traverse the firewall
# Input is firewall hash reference and value of current delay
# if caught returns True to continue trying
sub traverse {
	(my $hRef, my $d) = @_;
	my $c = 0;
	
	for(my $i=0;$i<89;$i++) {
		if (exists $hRef->{$i}) {
			$step = ($hRef->{$i} * 2) - 2;
			if(($i+$d) % $step == 0) {
				#$c = $c + ($i * $hRef->{$i});
				# if caught, return true
				return(1);
				
			}
		}
	}
	
	# return($c);
	# Not caught!
	return(0);
}
