#!/usr/local/bin/perl
use warnings;
use strict;

my %tower;
my %weight;
my $prnt = '';
my @wght;
my @parents;
my @children;
my @line;
my $base = '';
my $found = 0;
#my $num = 5;

#open(MYFILE,"<input.txt") or die "Can't open input file: $!";
open(MYFILE,"<inputFixed.txt") or die "Can't open input file: $!";

while(<MYFILE>) {
	chomp($_);
	@line = split(" ");
	
	$prnt = shift(@line);
	
	@wght = split('',shift(@line));
	pop(@wght);shift(@wght);
	
	$weight{$prnt} = join('',@wght);
			
	push(@parents,$prnt);
	
	if(scalar(@line) > 1) {
		shift(@line);
		#if(scalar(@line) < $num) { $num = scalar(@line); }
		$tower{$prnt} = join('',@line);
		push(@children,split(",",join('',@line)));
	}	
}

close(MYFILE);

# find the base of the tower
for(my $i=0;$i<scalar(@parents);$i++) {
	$found = 0;
	
	for(my $c=0;$c<scalar(@children);$c++) {
		if($parents[$i] eq $children[$c]) {
			$found++;
			$c = scalar(@children);
		}		
	} # End nested for
	
	if(!$found) {
		$base = $parents[$i];
		$i = scalar(@parents);
	}
}
	
print "The Tower base is $base \n";
#print "the smallest number of children is $num\n";

# clean up some of the data
@parents = (); @children = ();

print getTowerWeights($base,\%tower,\%weight);
print " is the weight of the whole tower\n";

exit 0;
#====================== End Main Section =============================

# Recursive function to find the weight of all the disks in the tower
sub getTowerWeights {
	(my $b, my $tRef, my $wRef) = @_;
	my @kids;
	my $bDisk = join('',$b,'-d');
	my $dWght = 0;
	
	# Base Case, if no children on a disk, set the 'disk weight' and return
	if(! exists($tRef->{$b})) {
		$wRef->{$bDisk} = 0;
		return;
	}
	
	@kids = split(',',$tRef->{$b});
	
	foreach my $e (@kids) {
		getTowerWeights($e,$tRef,$wRef);
	}
	
	for(my $k=0;$k<scalar(@kids);$k++) {
		my $diff = 0;
		$dWght = $dWght + $wRef->{$kids[$k]} + $wRef->{join('',$kids[$k],'-d')};
		
		if($k+2 < scalar(@kids)) {
			my $w1 = $wRef->{$kids[$k]} + $wRef->{join('',$kids[$k],'-d')};
			my $w2 = $wRef->{$kids[$k+1]} + $wRef->{join('',$kids[$k+1],'-d')};
			my $w3 = $wRef->{$kids[$k+2]} + $wRef->{join('',$kids[$k+2],'-d')};
			
			if($w1 == $w2 && $w1 != $w3) {
				# W3 is the issue
				$diff = abs($w1 - $w3);
				print "$kids[$k+2] is the issue, it's weight is $wRef->{$kids[$k+2]} ";
				print "but it's off by $diff and should be ";
				print $wRef->{$kids[$k+2]} - $diff . "\n"; die;
			} elsif($w1 != $w2 && $w1 == $w3) {
				# W2 is the issue
				$diff = abs($w1 - $w2);
				print "$kids[$k+1] is the issue, it's weight is $wRef->{$kids[$k+1]} ";
				print "but it's off by $diff and should be ";
				print $wRef->{$kids[$k+1]} - $diff . "\n"; die;
			} elsif($w1 != $w2 && $w1 != $w3) {
				# W1 is the issue
				$diff = abs($w1 - $w3);
				print "$kids[$k] is the issue, it's weight is $wRef->{$kids[$k]} ";
				print "but it's off by $diff and should be ";
				print $wRef->{$kids[$k]} - $diff . "\n"; die;
			}
			
		} # end If
	} # end For
	
	$wRef->{join('',$b,'-d')} = $dWght;
	
	return($wRef->{$b} + $dWght);
}
