#!usr/local/bin/perl
use strict;
use warnings;
use Data::Dumper;

my @arr = (0,1,2,3,4,5,6);
my @combos;

@combos = getCombos(\@arr);

@combos = sort(@combos);

print Dumper(@combos);

exit(0);
#====================== End Main Section =============================
sub getCombos {
	my @a = @{$_[0]};
	my @c = ();
	my $e = 0;
	
	while (scalar(@a) > 0) {
		if (scalar(@c) == 0) {
			$e = pop(@a);
			push(@c,$e);
		} else {
			$e = pop(@a);
			@c = addElem(\@c,$e);
		}
	}
	
	return (@c);
}

sub addElem {
	my ($ref, $e) = @_;
	my @a1 = @{$ref};
	my @newA = ();
	my @newI = ();
	
	while (scalar(@a1) > 0) {
		my $item = pop(@a1);
		@newI = split('',$item);
	
		for (my $i=0;$i<scalar(@newI);$i++) {
			splice(@newI,$i,0,$e);
			push(@newA,join('',@newI));
			splice(@newI,$i,1);
		}
	
		push(@newI,$e);
		push(@newA,join('',@newI));
	}
	
	return (@newA);	
}
