#!/usr/bin/perl
use warnings;
use strict;

my @currGp = ();
my $c = 0;
my $totalYes = 0;


open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	if (length($_) == 0) {
		#process group
		$c++;
		my %grpAns; #new hash to process the current passport
			
		foreach my $q (@currGp) { # put the answer into a group hash
			$grpAns{$q} = 1;
		}
		
		$totalYes += scalar(keys %grpAns);
		
		#end of processing; prep for next group in batch
		@currGp = ();
	} else {
		#continue reading from batch file
		push(@currGp,split(''));
	}
}

close(INPUT);

print "For $c groups, the number of questions answered yes is $totalYes.\n";

exit(0);
#==========================================================================
