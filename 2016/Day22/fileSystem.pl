#!usr/local/bin/perl
use warnings;
use strict;

my @avail;
my @used;
my @grid;
my @drive;
my $elemt = '';
my $count = 0;
my $g = 0;

for (my $i=0;$i<34;$i++) {
	my @a = ();
	push(@grid,\@a);
}

open(MYFILE,"<input.txt") or die "Can't open input file: $!";

while (<MYFILE>) {
	chomp($_);
	@drive = split(' ',$_);

	push(@used,substr($drive[2],0,(length($drive[2])-1)));
	push(@avail,substr($drive[3],0,(length($drive[3])-1)));
	
	if ($count < 35) {
		if (substr($drive[2],0,(length($drive[2])-1)) > 400) {
			push($grid[$g],"xx/xx");
		} else {
			push($grid[$g],substr($drive[2],0,(length($drive[2])-1))."/".substr($drive[1],0,(length($drive[1])-1)));
		}
		$count++;
	} else {
		$g++;
		$count = 0;
		push($grid[$g],substr($drive[2],0,(length($drive[2])-1))."/".substr($drive[1],0,(length($drive[1])-1)));
		$count++;
	}
		
}

close(MYFILE);

open(OUTPUT,">out.txt") or die "Can't open output file: $!";

print "there are $count nodes\n";
$count = 0;

for (my $i=0; $i<scalar(@used);$i++) {
	if ($used[$i] != 0) {	
		for (my $k=0;$k<scalar(@avail);$k++) {
			if ($i != $k) {
				if ($used[$i] <= $avail[$k]) {
					$count++;
				}
			}
		}
	}
}

print "number of viable pairs is $count\n";

for (my $y=0;$y<35;$y++) {
	for (my $x=0;$x<30;$x++) {
		print OUTPUT $grid[$x][$y]." ";
	}
	print OUTPUT "\n";
}

close(OUTPUT);

exit(0);
#====================== End Main Section =============================

