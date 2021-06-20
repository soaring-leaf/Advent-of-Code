#!/usr/local/bin/perl
use warnings;
use strict;

my @line;
my @path;
my $x = 0;
my $y = 0;
my $dir = 1; # Direction is 1=Down; 2=up; 3=right; 4=left
my $track = '';
my $steps = 1;

#open(MYFILE,"<test.txt") or die "Can't open input file $!";
open(MYFILE,"input.txt") or die "Can't open input file $!";

# Read in the path
while(<MYFILE>) {
	chomp($_);
	@line = split('');
	
	for(my $i=0;$i<scalar(@line);$i++) {
		if($line[$i] ne ' ') {
			$path[$i][$y] = $line[$i];
		}
	}
	$y++;
}

close(MYFILE);
$y = 0; # Reset y back to 0

# Locate the start of the path in the first row
my $notFound = 1; 
while($notFound) {
	if(defined $path[$x][0]) {
		$notFound--;
	} else {
		$x++;
	}
} # end While

# Traverse the path
$notFound = 1; # Looking for the end of the path now
while($notFound) {
	# update the position
	if($dir == 1) {
		$y++;
	} elsif ($dir == 2) {
		$y--;
	} elsif ($dir == 3) {
		$x++;
	} else {
		$x--;
	}
	
	#print "at $x, $y: $path[$x][$y]\n";
	
	if(exists $path[$x][$y]) {
		$steps++;
		# check contents of next position
		# if not -, | or +; record letter
		if($path[$x][$y] ne '-' and $path[$x][$y] ne '|' and $path[$x][$y] ne '+') {
			$track = $track . $path[$x][$y];
		}
	
		# update direction if needed
		if($path[$x][$y] eq '+')  {
			#print "checking direction, at $x, $y \n";
			if(exists $path[$x][$y-1] and $dir != 1) {
				#print "changing to 2\n";
				$dir = 2;
			} elsif(exists $path[$x-1][$y] and $dir != 3) {
				#print "changing to 4\n";
				$dir = 4;
			} elsif (exists $path[$x][$y+1] and $dir != 2) {
				#print "changing to 1\n";
				$dir = 1;
			} elsif (exists $path[$x+1][$y] and $dir != 4) {
				#print "changing to 3\n";
				$dir = 3;
			} else {
				die "craaaaap not following path properly";
			}
		} # end update direction
	} else {
		$notFound--;
	}
	
} # end While loop

print "path taken follows $track and goes $steps steps.\n";

exit 0;
#====================== End Main Section =============================


