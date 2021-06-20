#!/usr/bin/perl
use warnings;
use strict;

my %bagList = (); 	# Hash of all the Bags and what they can hold
my @bagKeys = ();	# List of keys for the Bag Hash
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

@bagKeys = keys(%bagList);

# for each bag color need to go through the list and see if any sub-bag is a shiny gold one
# good case for recursion
foreach my $bKeys (@bagKeys) {
	if ($bKeys eq 'shiny gold') {
		#do nothing
	} else {
		$count += bagCheck(\%bagList,$bKeys);
	}
}

print "We can carry shiny gold bags within $count other bags.\n";

exit(0);
#==========================================================================
sub bagCheck {
	my %bags = %{$_[0]}; # Gets a copy of the Bag List Hash
	my @currList = @{$bags{$_[1]}}; # Gets the list of bags the current Bag holds
	my $gold = 0;
	
	# print "$_[1] contains ";
	# foreach my $e (@currList) {
		# print $e . " ";
	# }
	# print "\n";
	
	if ($currList[1] eq 'other bags.') {
		# Root Case - Current Bag holds [no,other bags]
		return 0;
	} 
	
	for (my $b=1;$b<scalar(@currList);$b+=2) {
		if($currList[$b] eq 'shiny gold') {
			$gold++;
			$b = scalar(@currList);
		}
	}
	
	if($gold) {
		# If we found our shiny gold bags, return True
		return $gold;
	} else {
		# Need to go through the list and see if any of these contain Gold
		for (my $b=1;$b<scalar(@currList);$b+=2) {
			#print "about to recurse $_[0], $currList[$b] from $_[1] \n";
			$gold = bagCheck($_[0],$currList[$b]);
			
			if($gold) {
				#if our gold bag is found, then return Gold
				return $gold;
			}
		}
	}
	
	#if no gold is found return (False) gold
	return $gold;
}