#!/usr/bin/perl
use warnings;
use strict;

my %bagList = (); 	# Hash of all the Bags and what they can hold
my $currBag = "";	# Initializing %bagList
my @currVal = ();	# Initializing %bagListarg
my $value = "";
my $count = 0;

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	my @tempList = ();
	
	chomp;
	($currBag,$value) = split(' bags contain ');
	@currVal = split(' ',$value);
	
	if ($currVal[0] eq 'no') {
		$currVal[0] = 0;
	}
	
	for (my $i=0;$i<scalar(@currVal);$i++) {
		if ($i % 4 == 0) {
			push(@tempList,$currVal[$i]);
		} elsif ($i % 4 == 1) {
			$value = $currVal[$i] . " " . $currVal[$i+1];
			push(@tempList,$value);
			$i++;
		} elsif ($i % 4 == 3) {
			# do nothing
		}
	}
	
	$bagList{$currBag} = \@tempList;
}

close(INPUT);

$count = bagCheck(\%bagList,'shiny gold');

print "Our shiny gold bags contains $count other bags.\n";

exit(0);
#==========================================================================
sub bagCheck {
	my %bags = %{$_[0]}; # Gets a copy of the Bag List Hash
	my @currList = @{$bags{$_[1]}}; # Gets the list of bags the current Bag holds
	my $currCount = 0;
	my $total = 0;
	
	# print "$_[1] contains ";
	# foreach my $e (@currList) {
		# print $e . " ";
	# }
	# print "\n";
	
	if ($currList[1] eq 'other bags.') {
		# Root Case - Current Bag holds ['X',other bags]
		# return 'X'
		return $currList[0];
	} 
	
	for (my $b=1;$b<scalar(@currList);$b+=2) {
		$currCount = bagCheck($_[0],$currList[$b]);
		
		if ($currCount == 0) {
			$total += $currList[($b-1)];
		} else {
			$total += (($currList[($b-1)] * $currCount) + $currList[($b-1)]);
			
			# Update the current bag if we don't already know how many 
			# bags they contain
			# if ($_[0]->{$currList[$b]}->[1] ne 'other bags.') {
				# my @newCount = [$currCount,'other bags.'];
				# $_[0]->{$currList[$b]} = \@newCount;
			# }
		}
		
	}
	
	# send back the total contained bags
	return $total;
}