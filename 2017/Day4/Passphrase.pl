#!/usr/local/bin/perl
use warnings;
use strict;

my $validCount = 0;
my @phrase;
my @phraseList;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	@phrase = split(" ");
	
	# Initial check to see if any words are the same
	if (phraseCheck1(\@phrase)) {
		push(@phraseList,join(' ',@phrase));
		@phrase = ();
	}
}

close MYFILE;

# Check to see if any words contain the same characters (anagram)
foreach my $p (@phraseList) {
	if(phraseCheck2($p)) {
		$validCount++;
	}
}

# Part 1: Tallies up number of valid options
#$validCount = scalar(@phraseList);

print "Number of valid passphrases: $validCount \n";

exit 0;
#====================== End Main Section =============================

# First check(Part 1) of the Passphrase for validity
# Insuring no word is repeated in the phrase
sub phraseCheck1 {
	my @p = @{$_[0]};
	
	for(my $i=0;$i<(scalar(@p)-1);$i++) {
		for(my $c=$i+1;$c<scalar(@p);$c++) {
			if($p[$i] eq $p[$c]) {
				return(0);
			}
		} # End nested for
	} # End for loop
	
	return(1);
}

# Now need to check for anagrams of the words
sub phraseCheck2 {
	my @p = split(" ",$_[0]);
	
	for(my $i=0;$i<(scalar(@p)-1);$i++) {
		for(my $c=$i+1;$c<scalar(@p);$c++) {
			if(length($p[$i]) == length($p[$c])) {
				if(isAnagram($p[$i],$p[$c])) {
					return(0);
				}
			}
		} # End nested for
	} # End for loop
	
	return(1);
} 

# Check if word 1 is an anagram of word 2
sub isAnagram {
	my @w1 = split("",$_[0]);
	my @w2 = split("",$_[1]);
	my %wHsh1;
	my %wHsh2;
	my @keys;
	my $valid = 0;
	
	foreach my $c (@w1) {
		if(exists($wHsh1{$c})) {
			$wHsh1{$c}++;
		} else {
			$wHsh1{$c} = 1;
		}
	}
	
	foreach my $c2 (@w2) {
		if(exists($wHsh2{$c2})) {
			$wHsh2{$c2}++;
		} else {
			$wHsh2{$c2} = 1;
		}
	}
	
	@keys = keys(%wHsh1);
	
	for(my $k=0;$k<scalar(@keys);$k++) {
		if(exists($wHsh2{$keys[$k]})) {
			if($wHsh1{$keys[$k]} != $wHsh2{$keys[$k]}) {
				# if count of a letter isn't the same in the
				# second word, not an anagram
				return(0);
			}
				
		} else { # if a letter doesn't match, not an anagram
			return(0);
		}
		
	}
	
	# If all checks to eliminate anagram fail, it's an anagram
	return(1);
}
