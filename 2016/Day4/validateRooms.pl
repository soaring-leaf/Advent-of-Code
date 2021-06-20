#!/usr/local/bin/perl
use warnings;
use strict;

my @room;
my %list = ();
my $name = '';
my $val = 0;
my $sum = 0;
my $check = '';
my $str = '';
my $valid;


open(MYFILE,"<input.txt") or die "Couldn't open file: $!";

while (<MYFILE>) {
	chomp($_);
	@room = ();
	
	@room = split('-',$_);
	
	$check = pop(@room);
	$name = join(' ',@room);
	$str = join('',@room);
	#print "name is $name; string is $str\n";
	@room = split('',$str);
	@room = sort(@room);
	
	$str = join('',@room);
	
	($check,$val) = split(']',$check);
	($val,$check) = split('\[',$check);
	
	$valid = roomCheck($check,@room);
	#print "after sub, validation is $valid; room should have value of: $val\n";
	
	if ($valid) {
		$list{$name} = $val;
		$sum = $sum + $val;
	}
}

print "value of valid rooms is $sum\n";

findNProom(\%list);

exit 0;
#====================== End Main Section =============================
sub roomCheck {
	my $c = shift;
	my @r = @_;
	my %elmts;
	my $num = 0;
	my $last = '';
	my $top5;
	
	foreach my $e (@r) {
		if ($e eq $last) {
			$num++;
		} elsif ($last ne '') {
			$elmts{$last} = $num;
			$num = 1;
			$last = $e;
		} else {
			$last = $e;
			$num++;
		}
	}
	$elmts{$last} = $num;
	
	@r = sort{ $elmts{$b} <=> $elmts{$a} or $a cmp $b } keys(%elmts);
	
	$top5 = join('',splice(@r,0,5));
	
	#print "check is $c and top 5 are $top5\n";

	if ($c eq $top5) {
		return 1;
	} else {
		return 0;
	}
}

#finds the room named North Pole objects prints out the sector ID
sub findNProom {
	my %h = %{$_[0]};
	my @L = keys %h;
	my $v = 0;
	
	#key is the name of the room, the value is the SectorID
	foreach my $n (@L) {
		decrypt($n,$h{$n});
		#print "and room has value of ".$h{$n}."\n";
	}
}

sub decrypt {
	my $r = shift;
	my $id = shift;
	my $rotate = 0;
	my @n = split('',$r);
	
	$rotate = $id % 26;
	
	open (OUTPUT,">>out.txt") or die "can't open output file: $!";
	
	for (my $i=0;$i<scalar(@n);$i++) {
		for (my $k=0;$k<$rotate;$k++) {
			if ($n[$i] ne ' ') {
				$n[$i]++;
				if (length($n[$i]) == 2) {
					$n[$i] = substr($n[$i],0,1);
				}
			}
		}
	}
	
	$r = join('',@n);
	
	print OUTPUT "decoded room name is: $r and has ID of $id\n";
	
	if ($r eq 'northpole object storage') {
		print "decoded room name is: $r and has an ID of $id\n";
	}
	
	close(OUTPUT);
	
}










