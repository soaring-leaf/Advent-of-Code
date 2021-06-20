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
my $min = -1;

for (my $i=0; $i<5;$i++) {
	getItems(\@items,\@weapons,$i);
	foreach my $e (@items) {
		$p1[1] = $p1[1] + $e->[1];
	}
	$winner = fight(\@boss,\@p1);
	print "hit points are now $p1[1]\n";
	print "winner of $i is $winner\n";
	@items = ();
}


exit(0);
#====================== End Main Section =============================
sub getItems {
	my ($e,$w,$i) = @_;
	my @E = @$e;
	
	push(@E,$w->[$i]);
	$e = \@E;	
}

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
	
	print "player H:".$p[0]."A:".$p[1]." D:".$p[2]."\n";
	print "boss H:".$b[0]."A:".$b[1]." D:".$b[2]."\n";
	
	if ($p[0] <= 0) {
		return "boss";
	} else {
		return "player";
	}
}
