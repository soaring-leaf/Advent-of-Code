#!/usr/local/bin/perl
use warnings;
use strict;

my @pos;	# Array of positions
my @vel;	# Array of velocities
my @maxMin = (0,0,0,0);
my $coord = '';
my $diff = 0;

open (MYFILE,"<input.txt") or die "Can't open file: $!";

while (<MYFILE>) {
	chomp;
	$coord = substr($_,10,index($_,'>')-10);
	if(substr($coord,0,1) eq '-') {
		$coord = substr($coord,1);
	}
	push($pos,$coord);
	
	$coord = substr($_,index($_,'<',11)+1);
	$coord = substr($coord,0,length($coord)-1);
	push(@vel,$coord);
}

close(MYFILE);


# Part 1
#=================================
findMessage(\@pos,\@vel);

# Part 2
#=================================


exit 0;
#====================== End Main Section =============================
sub findMessage {
	my $pRef = $_[0];
	my $vRef = $_[1];
	my @p2 = @{$pRef};
	my $d1 = getDifferential($pRef);
	my $d2 = -1;
	
	while($d2 < $d1) {
		
	}
}

sub updatePositions {
	my $posRef = $_[0];
	my $vRef = $_[1];
	my $x = 0;
	my $y = 0;
	my $vX = 0;
	my $vY = 0;
	
}

sub getDifferential {
	my @p = @{$_[0]};
	my $min;
	my $max;
	my @loc;
	
	@loc = split(', ',$p[0]);
	$min = $loc[1];
	$max = $min;
	
	for(my $i=1;$i<scalar(@p);$i++) {
		@loc = split(', ',$p[$i]);
		if($min > $loc[1]) {
			$min = $loc[1];
		}
		if($max < $loc[1]) {
			$max = $loc[1];
		}
	}
	
	return (abs($max)+abs($min));
}
