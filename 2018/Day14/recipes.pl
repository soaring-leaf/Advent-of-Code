#!/usr/local/bin/perl
use warnings;
use strict;

#my @scores = (3,7);
my $scores = '37';
my $e1 = 0;
my $e2 = 1;
my $total = 0;
my $count = 2;
my $num = '157901';
my $found = 0;
my $test = '';

# Part 1
#=================================
#while($count < ($num+10)) {
#	$total = $scores[$e1] + $scores[$e2];
#	if($total < 10) {
#		push(@scores,$total);
#		$count++;
#	} else {
#		push(@scores,split('',$total));
#		$count = $count + 2;
#	}
#	
#	$e1 = (1 + $e1 + $scores[$e1]) % scalar(@scores);
#	$e2 = (1 + $e2 + $scores[$e2]) % scalar(@scores);
#}

#for(my $i=$num;$i<$num+11;$i++) {
#print $scores[$i];
#}

#print "\n";

# Part 2
#=================================
while(!$found) {
	$total = substr($scores,$e1,1) + substr($scores,$e2,1);
	if($total < 10) {
		$scores = $scores . $total;
		$count++;
	} else {
		$scores = $scores . $total;
		$count = $count + 2;
	}
	
	$e1 = (1 + $e1 + substr($scores,$e1,1)) % length($scores);
	$e2 = (1 + $e2 + substr($scores,$e2,1)) % length($scores);
	
	if(substr($scores,-6) eq $num || substr($scores,(length($scores)-7),6) eq $num) {
		$found++;
	}
	
	if($count % 1000000 == 0) {
		print "working on $count recipes\n";
	}
	
	$test = '';
}

print "found after " . index($scores,$num) . " recipies\n";

exit 0;
#====================== End Main Section =============================

