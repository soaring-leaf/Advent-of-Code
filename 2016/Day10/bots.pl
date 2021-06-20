#!/usr/local/bin/perl
use warnings;
use strict;

package Bot;	# This is the class

sub new	{	#the constructor
	my $class = shift;
	my $self = { # internal structure to represent data in class as a hash ref
		id => shift,	# bot's ID number
		h1 => 0,	# chip ID No. 1
		h2 => 0,	# chip ID No. 2
		holding => 0,	# number of chips bot is holding 
		orders => shift, # set of instructions for this bot; should be in the form of 'LowBot highBot'
		friends => shift, # will be a hash reference to other bots
	};
	
	bless($self,$class); # makes $self an object of the class
	
	return $self;
}

# Returns the instruction for this bot when it is holding two chips
# This is in the form of 'LowBot HighBot' with one space separating them
# If negitive number, that will be designated output
sub getInstr {
	my $self = shift;
	return $self->{orders};
}

# Returns ID of bot
sub getID {
	my $self = shift;
	return $self->{id};
}

# Returns reference to hash holding all the other bots
sub getFriends {
	my $self = shift;
	return $self->{friends};
}

# Returns the number of items held
sub getNumHolding { 
	my $self = shift;
	return $self->{holding};
}

# Returns value of chips being held as a list
# or 0 if not holding anything
sub getHolding {
	my $self = shift;
	my $num = $self->getNumHolding();
	
	if ($num == 0) {
		return 0;
	} elsif ($num == 1) {
		return $self->{h1};
	} else {
		return ($self->{h1},$self->{h2});
	}	
}

# Called when bot is activated and hands off chips
# Resets both hands to 0
sub setHolding {
	my $self = shift;
	$self->{h1} = 0;
	$self->{h2} = 0;	
}
# defines what happens when a bot is given a chip
# takes chip into h1 or if already holding a chip, takes larger chip into h2 
# and lesser chip into h1. If now holding 2 chips, needs to activate and hand off chips.
sub receiveChip {
	my $self = shift;
	my $chip = shift;
	my @hands = $self->getHolding();
	
	if ($hands[0] == 0) {
		$self->{h1} = $chip;
		$self->{holding}++;
	} else {
		if ($hands[0] < $chip) {
			$self->{h2} = $chip;
			$self->{holding}++;
		} else {
			$self->{h2} = $self->{h1};
			$self->{h1} = $chip;
			$self->{holding}++;
		}
	}
	
	if ($self->{holding} == 2) {
		$self->activate();
		$self->{holding} = 0;
	}
}

# Method for handing off chips
sub activate {
	my $self = shift;
	my $botRef = $self->getFriends();
	(my $bLow, my $bHigh) = split(' ',$self->getInstr());
	(my $cLow, my $cHigh) = $self->getHolding();
	
	# check here if this bot is comparing the chips we are looking for
	if (($cLow == 17) && ($cHigh == 61)) {
		print "I am comparing the chips and I am bot ".$self->getID()."\n";
	}
	
	# give low chip(cLow) to low bot (bLow) and cHigh to bHigh
	# Negative values indicate that chip goes to that output bin rather than a bot
	if ($bLow < 0) {
		print OUTPUT "output $bLow $cLow\n";		
	} else {
		($botRef->{$bLow})->receiveChip($cLow);
	}
	if ($bHigh < 0) {
		print OUTPUT "output $bHigh $cHigh\n";
	} else {
		($botRef->{$bHigh})->receiveChip($cHigh);
	}	
	
	$self->setHolding();
}

#============================= End Package Bot =================================

my @inits;
my %bots;
my $str = '';
my $b = 0;

system("del out.txt");

open(MYFILE,"<input.txt") or die "Can't open input file: $!";
open(OUTPUT,">out.txt") or die "Can't open output file: $!";

while (<MYFILE>) {
	my @line;

	chomp($_);
	@line = split(' ',$_);
	if ($line[0] eq 'value') {
		shift(@line);
		$str = pop(@line)." ".shift(@line);
		push(@inits,$str);
	} else {
		shift(@line);
		$b = shift(@line);
		shift(@line); shift(@line); shift(@line);
		$str = processInstr(@line);
		
		# create Robot with it's instruction
		my $robot = new Bot($b,$str,\%bots);
		$bots{$b} = $robot;
	}
}

close(MYFILE);

# process giving out the chips from the Itits array
foreach my $v (@inits) {
	my @line = split(' ',$v);
	$bots{$line[0]}->receiveChip($line[1]);	
}

close(OUTPUT);

open(INPUT,"<out.txt") or die "Can't read output file: $!";

my @nums;

while(<INPUT>) {
	my @line = split(' ',$_);
	
	if (($line[1] eq '-1') || ($line[1] eq '-2')) {
		push(@nums,$line[2]);
	}
}

print "Output multipliers is: ";
print $nums[0]*$nums[1]*$nums[2]."\n";

close(INPUT);
exit 0;
#====================== End Main Section =============================
sub processInstr {
	my @l = @_;
	my $bStr = '';
	my $oStr = shift(@l);
	my $h = pop(@l);
	
	if ($oStr eq 'output') {
		$bStr = 0 - shift(@l);
		if ($bStr == 0) {
			$bStr = -1;
		}
	} else {
		$bStr = shift(@l);
	}
	
	$oStr = pop(@l); 
	if ($oStr eq 'output') {
		$h = 0 - $h;
		if ($h == 0) {
			$h = -1;
		}
	}
	
	$bStr = $bStr.' '.$h;
	
	return $bStr;	
}
