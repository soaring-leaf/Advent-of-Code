#!/usr/local/bin/perl
use warnings;
use strict;

my $word;
my $vcount = 0;
my $hasDouble = 0;
my $isBad = 0;
my $niceCount = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";
#open (MYFILE,"<test.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	$word = $_;
	
	$isBad = checkBad($word);
	
	if ($isBad eq '0') {
		($vcount, $hasDouble) = checkChars($word);
	}
	
	if ( ($isBad eq '0') && ($hasDouble eq '1') && ($vcount > 2) ) {
			$niceCount++;
	}
	
	#print "word: $word; bad chars: $isBad; vcount: $vcount; doubles: $hasDouble \n";
	
	#reset vars
	$isBad = 0;
	$vcount = 0;
	$hasDouble = 0;
	
} # end while loop

close MYFILE;
print "$niceCount words that are nice were found. \n";
#print "Highest floor reached is $maxFloor. \n";
#print "Lowest sub-basement reached is $minFloor. \n";

exit 0;
#====================== End Main Section =============================
sub checkBad {
	my $w = $_[0];
	my @badChars = ('ab','cd','pq','xy');
	my $bool = 0;
	
	for (my $i=0; $i<4; $i++) {
		if ( index($w,$badChars[$i]) > -1 ) {
			#print "check result: " . index($w,$badChars[$i]) . "\n";
			$bool = 1;
		}
	}
	
	return $bool;
}

sub checkChars {
	my $vowels = 'aeiou';
	my $count = 0;
	my @chars = split('',$_[0]);
	my $ch1 = $chars[0];
	my $ch2 = '';
	my $dBool = 0;

	
	for (my $i=0; $i < scalar(@chars); $i++) {
		if (index($vowels,$chars[$i]) > -1) {
			$count++;
		} #end vowel count if
		
		if ( ($i > 0) && (!$dBool) ) {
			$ch2 = $chars[$i];
			
			if ($ch1 eq $ch2) {
				$dBool = 1;
			} else {
				$ch1 = $ch2;
			}
		} #end nested if for double char check
			
	}# end for loop
	
	return $count, $dBool;
}
