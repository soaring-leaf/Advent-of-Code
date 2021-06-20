#!/usr/bin/perl
use warnings;
use strict;

my @report;
my $found = 0;
my $num1 = 0;
my $num2 = 0;
my $num3 = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
	chomp;
	push(@report,$_);
}

close(INPUT);

@report = sort {$a <=> $b } @report;

for(my $i=0;$i<(scalar(@report)-2);$i++) {
	for(my $k=($i+1);$k<(scalar(@report)-1);$k++) {
		for (my $m=($k+1);$m<scalar(@report);$m++) {
			if ($report[$i] + $report[$k] + $report[$m] == 2020) {
				$num1 = $report[$i];
				$num2 = $report[$k];
				$num3 = $report[$m];
				$i = scalar(@report);
				$k = $i;
				$m = $i;
			}
		}
	}
}

print "Found numbers $num1 and $num2 and $num3 which multiply to \n";
print $num1*$num2*$num3;
print "\n";

exit(0);
#==========================================================================
