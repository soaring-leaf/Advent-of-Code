#!/usr/local/bin/perl
use warnings;
use strict;

my @record;	# Full Record of actions, to be sorted by date/time
my @item;	# holder for reading one step at a time to process
my $curr;	# current Guard
my $t1;		# time of falling asleep for processing and then used for adding up total time sleeping
my $t2;		# time of waking up for processing and then used for the minute guard was mostly asleep for
my %guards;	# list of guards
my $sleeper = 0; # Guard that is sleeping the longest
my $gArr; 	# reference for an individual Guard's hour array

open (MYFILE,"<input.txt") or die "Can't open file: $!";

while (<MYFILE>) {
	chomp;
	push(@record,substr($_,6));
}

close(MYFILE);

@record = sort(@record);

initGuards(\%guards,\@record);

# Part 1
#=================================
for(my $i=0;$i<scalar(@record);$i++) {
	@item = split(' ',$record[$i]);
	
	if($item[2] eq 'Guard') {
		$curr = $item[3];
	} else {
		$t1 = substr($item[1],3,2);
		$i++;
		@item = split(' ',$record[$i]);
		$t2 = substr($item[1],3,2);
		
		$gArr = $guards{$curr};
		
		for(my $c=$t1;$c<$t2;$c++) {
			$gArr->[$c]++;
		}
	}	
}

$t2 = 0;

foreach my $z (keys(%guards)) {
	$gArr = $guards{$z};
	$t1 = 0;
	for(my $y=0;$y<60;$y++) {
		$t1 = $t1 + $gArr->[$y];
	}
	if($t1 > $t2) {
		$sleeper = $z;
		$t2 = $t1;
	}
}

print "Sleepiest guard is $sleeper with $t2 minutes asleep;\n";

$t1 = 0;

for(my $x=0;$x<60;$x++) {
	if($guards{$sleeper}->[$t1] < $guards{$sleeper}->[$x]) {
		$t1 = $x;
		#print "slept $guards{$sleeper}->[$x] times at minute $x \n";
	}
}

print "and is almost always asleep at minute $t1.\n";

$sleeper = substr($sleeper,1);

print "\nChecksum for guard is (guard ID times minute most asleep): ". $sleeper*$t1 . "\n";

# Part 2
#=================================
$t1 = 0;
$t2 = 0;

for(my $t=0;$t<60;$t++) {
	foreach my $g (keys(%guards)) {
		if($t1 < $guards{$g}->[$t]) {
			$sleeper = $g;
			$t1 = $guards{$g}->[$t];
			$t2 = $t;
		}
	}
}

print "\nGuard that slept $t1 times at minute $t2 is $sleeper\n";

$sleeper = substr($sleeper,1);

print "Checksum for guard is: ". $sleeper*$t2 . "\n";

exit 0;
#====================== End Main Section =============================
sub initGuards {
	my ($h, $a) = @_;
	my @arr = @{$a};
	my @action;
	
	foreach my $e (@arr) {
		@action = split(' ',$e);
		if($action[2] eq 'Guard') {
			if(!defined($h->{$action[3]})) {
				my @guardArray = (0) x 60;
				$h->{$action[3]} = \@guardArray;
			}
		}
	}
}
