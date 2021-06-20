#!usr/local/bin/perl
use warnings;
use strict;
use Data::Dumper;

# player stats are (Life, Attack, Defense)
my @boss = (103,9,2);
my @p1 = (100,0,0);
my @items = ();
my $winner = '';
#items have (cost, Damage, Armor)
my @weapons = ([8,4,0],[10,5,0],[25,6,0],[40,7,0],[74,8,0]);
my @armor = ([13,0,1],[31,0,2],[53,0,3],[75,0,4],[102,0,5]);
my @ringsD = ([25,1,0],[50,2,0],[100,3,0]);
my @ringsA = ([20,0,1],[40,0,2],[80,0,3]);
my $cost = 0;
my @minStat = ();

#print "length of array is " . scalar(@minStat) . "\n";
#find minimum stats for player win
for (my $i=4;$i<11;$i++) {
	for (my $k=0;$k<11;$k++) {
		$p1[1] = $i;
		$p1[2] = $k;	
		$winner = fight(\@boss,\@p1);
		#print "winner is $winner\t player stats are: A:".$p1[1]." D:".$p1[2]."\n";
			
		if ($winner eq 'player')  {
			if (scalar(@minStat) == 0) {
				push(@minStat,[$i,$k]);
			} elsif ( $minStat[-1][0] != $i ) {
				push(@minStat,[$i,$k]);
			}
		}
	}
}

#calculate cost for each stat scenario, find cheapest
for (my $c=0;$c< scalar(@minStat);$c++) {
	push(@items,getAttItems(\@weapons,\@ringsA,$minStat[$c][0]));
	push(@items,getDefItems(\@armor,\@ringsD,$minStat[$c][1]));
	
	$cost = getCost(@items);
}

#print Dumper(\@minStat);
print "best cost is $cost\n";

exit(0);
#====================== End Main Section =============================
sub fight {
	my ($bRef,$pRef) = @_;
	my $turn = 1;
	my $d = 0;
	
	my @b = @{$bRef};
	my @p = @{$pRef};
	
	while ( ($p[0] > 0) && ($b[0] > 0) ) {
		if ($turn) {
			$d = $p[1] - $b[2];
			if ($d < 1) {
				$d = 1;
			}
			$b[0] = $b[0] - $d;
			$turn--;
		} else {
			$d = $b[1] - $p[2];
			if ($d < 1) {
				$d = 1;
			}
			$p[0] = $p[0] - $d;
			$turn++;
		}
		
	}
	
#	print "player H:".$p[0]."A:".$p[1]." D:".$p[2]."\n";
#	print "boss H:".$b[0]."A:".$b[1]." D:".$b[2]."\n";
	
	if ($p[0] <= 0) {
		return "boss";
	} else {
		return "player";
	}
}
