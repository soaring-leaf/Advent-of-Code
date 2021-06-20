#!/usr/local/bin/perl
use warnings;
use strict;

my @id;
my $countAs = 0; # 0 = no doubles or triples; 1 = both double AND triple
		# 2 = double only; 3 = triple only
my $doubles = 0;
my $triples = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

# Part 1
#=================================

while (<MYFILE>) {
	chomp;
	@id = split('');
	$countAs = checkID(\@id);
	
	if($countAs == 3 || $countAs == 1) {
		$triples++;
	}
	if($countAs == 2 || $countAs == 1) {
		$doubles++;
	}
	
	print "$_	$countAs \n";
	
	$countAs = 0;
}

close(MYFILE);

print "Doubles: $doubles, Triples: $triples\n";
print "Checksum for box IDs is: ";
print $doubles * $triples;
print "\n";

# Part 2
#=================================


exit 0;
#====================== End Main Section =============================
sub checkID {
	my @bID = @{$_[0]};
	my $checked = '';
	my $d = 0;
	my $t = 0;
	my $c = 1;
	
	for(my $i=0;$i<(scalar(@bID)-1);$i++) {
		if(index($checked,$bID[$i]) == -1) {
			$checked = $checked . $bID[$i];
			for(my $k=$i+1;$k<scalar(@bID);$k++) {
				if($bID[$i] eq $bID[$k]) {
					$c++;
				}
			}
		}
		
		if($c == 2) {
			$d = 1;
		} elsif($c == 3) {
			$t = 1;
		}
		
		$c = 1;
	}
	
	if($d == 1 && $t == 1) {
		return 1;
	} elsif ($d == 1) {
		return 2;
	} elsif ($t == 1) {
		return 3;
	} else {
		return 0;
	}
}
