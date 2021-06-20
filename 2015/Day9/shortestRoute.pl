#!/usr/local/bin/perl
use warnings;
use strict;
use List::MoreUtils qw(uniq);

my %hDist;
my @paths;
my @places;
my $currDist = 0;
my $minDist = 0;
my $max = 0;
my @arr;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	my ($p1, $j1,$p2, $j2,$dist) = split(' ',$_);
	$p1 = trim($p1);
	$p2 = trim($p2);
	$hDist{$p1}{$p2} = $dist;
	$hDist{$p2}{$p1} = $dist;
	
} # end while loop

close MYFILE;

@places = uniq(keys %hDist);

@arr = (0..(scalar(@places) - 1));

@paths = getCombos(\@arr);

foreach my $e (@paths) {
	$currDist = getDist($e,\@places,\%hDist);
	
	if ( $minDist == 0 ) {
		$minDist = $currDist;
	} elsif ($currDist < $minDist) {
		$minDist = $currDist;
	}
	
	if ($currDist > $max) {
		$max = $currDist;
	}
}

print "Shortest distance is $minDist \n";
print "Max distance is ".$max;

exit 0;
#====================== End Main Section =============================
sub getDist {
	my ($item,$p,$hRef) = @_;
	my @names = @{$p};
	my @path = split('',$item);
	my $d = 0;
	
	for (my $i=0;$i<(scalar(@path) - 1);$i++) {
		my $k = $i + 1;
		$d = $hRef->{$names[($path[$i])]}{$names[($path[$k])]} + $d;
	}

	return $d;
}

sub getCombos {
	my @a = @{$_[0]};
	my @c = ();
	my $e = 0;
	
	while (scalar(@a) > 0) {
		if (scalar(@c) == 0) {
			$e = pop(@a);
			push(@c,$e);
		} else {
			$e = pop(@a);
			@c = addElem(\@c,$e);
		}
	}
	
	return (@c);
}

sub addElem {
	my ($ref, $e) = @_;
	my @a1 = @{$ref};
	my @newA = ();
	my @newI = ();
	
	while (scalar(@a1) > 0) {
		my $item = pop(@a1);
		@newI = split('',$item);
	
		for (my $i=0;$i<scalar(@newI);$i++) {
			splice(@newI,$i,0,$e);
			push(@newA,join('',@newI));
			splice(@newI,$i,1);
		}
	
		push(@newI,$e);
		push(@newA,join('',@newI));
	}
	
	return (@newA);	
}

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
