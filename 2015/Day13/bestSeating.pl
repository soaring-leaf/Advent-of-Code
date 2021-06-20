#!/usr/local/bin/perl
use warnings;
use strict;
use List::MoreUtils qw(uniq);

my %hSeating;
my @arrangments;
my @names;
my $currChng = 0;
my $min = 0;
my $max = 0;
my @arr;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	my $units = 0;
	my @dir = split(' ',$_);
	my $p1 = trim(shift(@dir));
	my $p2 = trim(pop(@dir));
	
	$p2 = substr($p2,0,(length($p2) - 1));
	shift(@dir);
	if (shift(@dir) eq 'lose') {
		$units = join('','-',shift(@dir));
	} else {
		$units = shift(@dir);
	}
	
	$hSeating{$p1}{$p2} = $units;
	
} # end while loop

close MYFILE;

@names = uniq(keys %hSeating);

foreach my $f (@names) {
	my $me = 'self';
	$hSeating{$f}{$me} = 0;
	$hSeating{$me}{$f} = 0;
}

push(@names,'self');

@arr = (0..(scalar(@names) - 1));

@arrangments = getCombos(\@arr);

foreach my $e (@arrangments) {
	$currChng = getHappiness($e,\@names,\%hSeating);
	
#	if ( $minDist == 0 ) {
#		$minDist = $currDist;
#	} elsif ($currDist < $minDist) {
#		$minDist = $currDist;
#	}
	
	if ($currChng > $max) {
		$max = $currChng;
	}
}

print "Max change in happiness is ".$max;

exit 0;
#====================== End Main Section =============================
sub getHappiness {
	my ($item,$p,$hRef) = @_;
	my @names = @{$p};
	my @path = split('',$item);
	my $d = 0;
	
	for (my $i=0;$i<(scalar(@path) - 1);$i++) {
		my $k = $i + 1;
		$d = $d + $hRef->{$names[($path[$i])]}{$names[($path[$k])]};
		$d = $d + $hRef->{$names[($path[$k])]}{$names[($path[$i])]};
	}
	
	my $end1 = shift(@path);
	my $end2 = pop(@path);
	$d = $d + $hRef->{$names[$end1]}{$names[$end2]};
	$d = $d + $hRef->{$names[$end2]}{$names[$end1]};

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
