#!/usr/local/bin/perl
use warnings;
use strict;

my $lat = 0;	# x grid location
my $long = 0;	# y grid location
my $lat2 = 0;
my $long2 = 0;
my $pos = '0/0';# current position in x/y format
my @chars;
my $myStr = 0;
my $unique = 1;	# unique houses visited
my %santaPath;
my $fileName = 'input.txt';
my $whoTurn = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";
#open (MYFILE,"<test.txt") or die "Couldn't open file, $!";

$santaPath{$pos} = 1; # set starting house as visited

while (<MYFILE>) {
	$myStr = $_;
	@chars = split('',$myStr);
#	$floor = checkchar($myChar);

	for (my $i=0; $i < scalar(@chars); $i++) {
		
		if ($chars[$i] eq '^' ) {
			if ($whoTurn == 0) {
				$lat++;
			} else {
				$lat2++;
			}
		} elsif ($chars[$i] eq 'v' ) {
			if ($whoTurn == 0) {
				$lat--;
			} else {
				$lat2--;
			}
		} elsif ($chars[$i] eq '>' ) {
			if ($whoTurn == 0) {
				$long++;
			} else {
				$long2++;
			}
		} elsif ($chars[$i] eq '<' ) {
			if ($whoTurn == 0) {
				$long--;
			} else {
				$long2--;
			}	
		} else {
			print "character read is: ";
			print $chars[$i];
			print "\n";
			die "Error with input, expecting ^,v,< or > only";
		}
		
		if ($whoTurn == 0) {
			$pos = "$lat/$long";
		} else {
			$pos = "$lat2/$long2";
		}
		
		if ( !(exists $santaPath{$pos}) ) {
			#unique house
			$santaPath{$pos} = 1;
			$unique++;
		}
		
		# switch turns
		if ($whoTurn == 0) {
			$whoTurn++;
		} else {
			$whoTurn--;
		}
		
	} #end For
	
} # end while loop

close MYFILE;
print "Santa has visited $unique unique houses.";

exit 0;
#====================== End Main Section =============================

