#!usr/local/bin/perl
use strict;
use warnings;

my @arr = (2,3,4);
my $combos;

$combos = getCombos(\@arr,'1');
my @newarr = @{$combos};

foreach my $e (@newarr) {
	print "$e \t";
}
print "\n";

exit(0);
#====================== End Main Section =============================
sub getCombos {
	my ($ref, $i) = @_;
	
	my @a = @{$ref};
	
	for (my $i=0;$i<scalar(@a);$i++) {
		$a[$i]++;
	}
	
	return (\@a);
}
