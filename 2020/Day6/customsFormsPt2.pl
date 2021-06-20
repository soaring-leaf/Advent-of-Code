#!/usr/bin/perl
use warnings;
use strict;

my @currGp = ();
my @check = ();
my $gpCount = 0;
my $c = 0;
my $totalYes = 0;
my $valid = 1;


open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	if (length($_) == 0) {
		#process group
		$c++;
		
		if($gpCount == 1) {
			$totalYes += length($currGp[0]);
		} else {
			@check = split('',$currGp[0]);
			
			for (my $c=0;$c<length($currGp[0]);$c++) { 
				for (my $i = 1;$i<$gpCount;$i++) {
					if(index($currGp[$i],$check[$c]) == -1) {
						$i = $gpCount;
					} elsif ($i == ($gpCount-1) && index($currGp[$i],$check[$c]) >= 0) {
						$totalYes++;
					}
				}
			}
					
		}
		
		#end of processing; prep for next group in batch
		@currGp = ();
		@check = ();
		$gpCount = 0;
	} else {
		#continue reading from batch file
		if($gpCount == 0){
			push(@currGp,$_);
		} elsif (length($_) < length($currGp[0])) {
			unshift(@currGp,$_);
		} else {
			push(@currGp,$_);
		}
		
		$gpCount++;
	}
}

close(INPUT);

print "For $c groups, the number of questions everyone in the group answered yes is $totalYes.\n";

exit(0);
#==========================================================================
