#!/usr/local/bin/perl
use warnings;
use strict;

my $word;
my $vcount = 0;
my $isGood = 0;
my $niceCount = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";
#open (MYFILE,"<test.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	$word = $_;
	
	$isGood = checkChars($word);
	
	if ( ($isGood) ) {
		$niceCount++;
	}
	
	#print "word: $word; bad chars: $isBad; vcount: $vcount; doubles: $hasDouble \n";
	
	#reset var
	$isGood = 0;
	
} # end while loop

close MYFILE;
print "$niceCount words that are nice were found. \n";

exit 0;
#====================== End Main Section =============================
sub checkChars {
	my $w = $_[0];
	my $count = 0;
	my @chars = split('',$_[0]);
	my $ch1;
	my $dChar;
	my $letterBool = 0;
	my $pairBool = 0;
	my $len = scalar(@chars) - 2;
	
	for (my $i=0; $i < $len; $i++) {
		$ch1 = $chars[$i];
		
		$dChar = $chars[$i] . $chars[($i+1)];
		
		if ($ch1 eq $chars[($i+2)]) {
			$letterBool = 1;
		}
				
		if (index($w,$dChar,($i+2)) > 0) {
			$pairBool = 1;
		}
				
	}# end for loop
	
	if ($letterBool && $pairBool) {
		return '1';
	} else {
		return '0';
	}
} # end checkChars
