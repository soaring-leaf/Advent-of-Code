#!/usr/local/bin/perl
use warnings;
use strict;
use Data::Dumper;

#
#
#
# SOMETHING IS WRONG, 22767 IS TOO LOW
# MORE TROUBLESHOOTING IS NEEDED
#
#

my @d1 = (5,2);		# 
my @d2 = (13,7);	#
my @d3 = (17,10);	# starting config of disks
my @d4 = (3,2);		#
my @d5 = (19,9);	#
my @d6 = (7,0);		#
my @d7 = (11,0);
my %disks;
my $time = -1;		# time
my $pod = 0;		# current level of the pod

$disks{1} = \@d1;
$disks{2} = \@d2;
$disks{3} = \@d3;
$disks{4} = \@d4;
$disks{5} = \@d5;
$disks{6} = \@d6;
$disks{7} = \@d7;

#system("del out.txt");
#open(OUTPUT,">>out.txt") or die "can't open output file: $!";

#print "\n\nThis is the copy:\n";

while ($pod < 8) {
	$time++;
	$pod = pushTheButton(\%disks);
	#print "============\n";
	#print Dumper %disks;
	#print OUTPUT "\npod got to $pod, Time checked is $time\n\n";
	updateDisks(\%disks);
	
	checkTime($time);
}	

print "push the button at $time\n";

exit 0;
# ========================= End Main Section ==================================
sub checkTime {
	my $t = shift;
	
	if (($t % 100000) == 0 ) {
		print "at time $t, still working\n";
	}
	
}
sub updateDisks {
	my $d = shift;
	
	for (my $i=1;$i<8;$i++) {
		my @a = @{$d->{$i}};
		$a[1]++;
		if ($a[1] == $a[0]) {
			$a[1] = 0;
		}
		$d->{$i} = \@a;
	}
	#print OUTPUT Dumper %{$d};
	#print OUTPUT "\n";
}

sub pushTheButton {
	my $d = $_[0];
	my %h = %{$d};
	my @keys = keys %h;
	my $i = 1;
	my $p = 0;
	my $good = 1;
	
	# make a true copy so not to mess up the
	# original disk hash configuration
	foreach my $k (@keys) {
		#print "key working on is: $i\n";
		my @a = @{$d->{$i}};
		$h{$i} = \@a;
		$i++;
	}
	
	#print Dumper %h;
	
	# step through to see if pod passes all disks
	while ( ($p < 8) && ($good) ) {
		$p++;
		updateDisks(\%h);
		#print "time is now $p\n";
		#print Dumper %h;
		#print "\n";
		if ($p == 8) {
			return $p;
		} elsif ($h{$p}->[1] != 0) {
			$good = 0;
		}
		
		#if ($p == 6) {
		#	$p++
		#}
	}
	
	return $p;
}
		
		
