#!/usr/local/bin/perl
use warnings;
use strict;

my $facing = 1; # 1-North, 2-East, 3-South, 4-West: 1,2 Positive; 3,4 Neg.
my $myStr = 0;
my $num = 0;
my $NS = 0;
my $EW = 0;
my @orders;
my $HQ = 0;
my $found = 0;
my %coords;
my @loc = ();

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	$myStr = $_;
	@orders = split(',',$myStr);

	for (my $i=0; $i < scalar(@orders); $i++) {
		my $step = trim($orders[$i]);
		my $turn = substr($step,0,1);
		$num = substr($step,1);
				
		#Update direction 
		if ($turn eq 'R' ) {
			$facing++;
			if ($facing > 4) {
				$facing = $facing - 4;
			}
		} else {
			$facing--;
			if ($facing < 1) {
				$facing = $facing + 4;
			}
		}
		
		#Update blocks
		if ($facing < 3) { #If facing is 1 or 2 add to direction
			if ($facing == 1) { #if facing N
				if ($found == 0) {
					for (my $i=0;$i<$num;$i++) {
						$NS++;
						$found = $found + isFound($NS,$EW,\@loc);
						if ($found == 0) {
							push(@loc,"$NS!$EW");
						}
					}
				} else {
					$NS = $NS + $num;
				}
			} else { #otherwise, facing East
				if ($found == 0) {
					for (my $i=0;$i<$num;$i++) {
						$EW++;
						$found = $found + isFound($NS,$EW,\@loc);
						if ($found == 0) {
							push(@loc,"$NS!$EW");
						}
					}
				} else {
					$EW = $EW + $num;
				}
			}
		} else { # Must then be facing S or W
			if ($facing == 3) { #if facing S
				if ($found == 0) {
					for (my $i=0;$i<$num;$i++) {
						$NS--;
						$found = $found + isFound($NS,$EW,\@loc);
						if ($found == 0) {
							push(@loc,"$NS!$EW");
						}
					}
				} else {
					$NS = $NS - $num;
				}
			} else { #otherwise, facing West
				if ($found == 0) {
					for (my $i=0;$i<$num;$i++) {
						$EW--;
						$found = $found + isFound($NS,$EW,\@loc);
						if ($found == 0) {
							push(@loc,"$NS!$EW");
						}
					}
				} else {
					$EW = $EW - $num;
				}
			}
		}
		
		# Check for HQ as first coords visited twice
		# Current answer of 267 is not right and too high.
		# Not just where you stop, but first corner you pass twice
#		if ($found == 0) {
#			my $pos = $NS."!".$EW;
#			$found = checkCoords($pos,@loc);
#			
#			if ($found) {
#				print "HQ is at $NS and $EW\n";
#				print "HQ is ".(makePos($NS)+makePos($EW))." blocks away.\n";
#			} else {
#				push(@loc,$pos);
#			}
#		}
#		if ($found == 0) {
#			if (defined $coords{$NS}) {
#				@loc = @{$coords{$NS}};
#				$found = checkCoords($EW,@loc);
#				print "length of array to check is ".scalar(@loc)."\n";
#				if ($found) {
#					print "HQ is ".(makePos($NS)+makePos($EW))." blocks away.\n";
#				} else {
#					push(@loc,$EW);
#				}
#				@{$coords{$NS}} = @loc;
#			} else {
#				push(@loc,$EW);
#				@{$coords{$NS}} = @loc;
#			}
#			@loc = ();
#		}
				

	} #end For
	
} # end while loop

close MYFILE;

print "found indicator is $found\n";
print "Distance EW is $EW. \n";
print "Distance NS is $NS. \n";

$EW = makePos($EW);
$NS = makePos($NS);


print "Min Number of blocks away is ".($NS+$EW)."\n";

exit 0;
#====================== End Main Section =============================
sub isFound {
	my $y = shift; # NS direction
	my $x = shift; # EW direction
	my $c = shift; # array holding coords already visited
	
	#print "coords being checked are $y $x\n";
	
	my $p = $y."!".$x;
	
	foreach my $e (@{$c}) {
		#print "element being checked is $e\n";
		if ($e eq $p) {
			print "HQ is at $y and $x\n";
			print "HQ is ".(makePos($y)+makePos($x))." blocks away.\n";
			return 1;
		}
	}
	
	return 0;
}

sub checkCoords {
	my $L = shift;
	my @items = @_;
	
	foreach my $e (@items) {
		if ($e eq $L) {
			return 1;
		}
	}
	
	return 0;
}

sub makePos {
	my $n = shift;
	
	if ($n < 0) {
		$n = $n * -1;
	}
	
	return $n;
}

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
