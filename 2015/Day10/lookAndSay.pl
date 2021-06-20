#!/usr/local/bin/perl
use warnings;
use strict;

my $input = 1321131112;
my @inArr;
my $len = 0;
my $num = 0;
my $count = 0;
my @new;

for (my $i = 0; $i < 50; $i++) {
	@inArr = split('',$input);
	$count = 0;
	$len = length($input);
	splice(@new);
	
	for (my $k= 0; $k < $len; $k++) {
		if ( ($k == 0) && ( ($k+1) ne $len ) ) { #if first num
			$count++;
		} elsif ( ($k+1) == $len ) { #end of string
			if ($k == 0) {
				$count++;
			} elsif ( !($inArr[$k] eq $inArr[$k-1]) ) { #if last num is different
				push(@new,$count);
				push(@new,$inArr[$k-1]);
				$count = 1;
			} else { #if last num is not different
				$count++;
			}
			
			push(@new,$count);
			push(@new,$inArr[$k]);
		} elsif ($inArr[$k] eq $inArr[$k-1]) { #if equals prev num
			$count++;
		} else { #new number in string
			push(@new,$count);
			push(@new,$inArr[$k-1]);
			$count = 1;
		}
		
		
		
	} #end nested for
	
	$input = join('',@new);
	#print "string is now $input\n";
	
} #end for

$len = length($input);

print "Length of input is $len.\n";

exit 0;
#====================== End Main Section =============================

