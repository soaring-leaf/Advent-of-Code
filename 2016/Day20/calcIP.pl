#!/usr/local/bin/perl
use warnings;
use strict;

my %ips;
my @hKeys;
my $low = 0;
my $high = 0;
my $next = 0;
my $found = 1;
my $count = 0;

open(MYFILE,"<input.txt") or die "Can't open input file: $!";
open(OUTPUT,">out.txt") or die "can't open output file: $!";

while (<MYFILE>) {
	chomp($_);
	my @line = split('-',$_);
	$ips{$line[0]} = $line[1];	
}

close(MYFILE);

$low = $ips{0} + 1;
@hKeys = sort {$a <=> $b} keys(%ips);

foreach my $e (@hKeys) {
	print OUTPUT "$e - $ips{$e}\n";
}
close(OUTPUT);

while ($high < 4294967295) {
	for(my $i=0; $i<scalar(@hKeys); $i++) {
		if ($hKeys[$i] <= $low) {
			if ($i == (scalar(@hKeys)-1)) {
				$next = $hKeys[$i];
			}
			if ($high < $ips{$hKeys[$i]}) {
				$high = $ips{$hKeys[$i]};
			}
		} else {
			$next = $hKeys[$i];
			last;
		}
	}
	
	if ($high >= $low) {
		$low = $high + 1;
	} elsif ($next < $low) {
		if ($next < $high) {
		$count = $count + (4294967295 - ($high));
		} else {
			$count = $count + (4294967295 - $ips{$next});
		}
		$high = 4294967295;
	} else {
		$count = $count + ($next - $low);
		$low = $ips{$next} + 1;
		print "found valid IPs, next is $next\n";
	}
}

#print "low ip in integer form is $low\n";
print "There are $count IPs in WhiteList \n";

exit(0);
#====================== End Main Section =============================

