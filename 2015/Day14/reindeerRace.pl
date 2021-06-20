#!/usr/local/bin/perl
use warnings;
use strict;

#Reindeer stats in order of:
# Name, State(1-fly, 0-rest),speed,for how long, rest time, distance covered, counter, points
my @rDeer = (['vixen',1,19,7,124,0,0,0],['rudolph',1,3,15,28,0,0,0],['donner',1,19,9,164,0,0,0],
	['blitzen',1,19,9,158,0,0,0],['comet',1,13,7,82,0,0,0],['cupid',1,25,6,145,0,0,0],
	['dasher',1,14,3,38,0,0,0],['dancer',1,3,16,37,0,0,0],['prancer',1,25,6,143,0,0,0]);
my $dist = 0;
my $pts = 0;

for (my $i =0; $i<2503; $i++) {
	processSecond(\@rDeer);	
	$dist = findWinner(\@rDeer);
	processPoints(\@rDeer,$dist);
}

$pts = findLeader(\@rDeer);

#print "Winner flew $dist KM.\n";
print "Winner has $pts points.\n";

exit 0;
#====================== End Main Section =============================
sub processSecond {
	my $ref = $_[0];
	
	for (my $k=0; $k<9;$k++) {
		#print "processing " . $ref->[$k][0] . "\n";
		# state is currently flying
		if ($ref->[$k][1]) {
			$ref->[$k][5] = $ref->[$k][5] + $ref->[$k][2];
			$ref->[$k][6]++;
		}
		# state is resting
		if ( !($ref->[$k][1]) ) {
			$ref->[$k][6]++;
		}
		#transitioning to resting
		if (($ref->[$k][3] eq $ref->[$k][6]) && ($ref->[$k][1])) {
			$ref->[$k][6] = 0;
			$ref->[$k][1] = 0;
		}
		#transitioning to flying
		if ( ($ref->[$k][4] eq $ref->[$k][6]) && !($ref->[$k][1]) ) {
			$ref->[$k][6] = 0;
			$ref->[$k][1] = 1;
		}
	}
		
}

sub processPoints {
	my ($ref, $max) = @_;
	
	for (my $q=0; $q<9;$q++) {
		if ($max eq $ref->[$q][5]) {
			$ref->[$q][7]++;
		}
	}
}

sub findWinner {
	my $ref = $_[0];
	my $d = 0;
	
	for (my $m=0; $m<9;$m++) {
		if ($d < $ref->[$m][5]) {
			$d = $ref->[$m][5];
		}
	}
	
	return $d;
}

sub findLeader {
	my $ref = $_[0];
	my $p = 0;
	
	for (my $n=0; $n<9;$n++) {
		if ($p < $ref->[$n][7]) {
			$p = $ref->[$n][7];
		}
	}
	
	return $p;
}
