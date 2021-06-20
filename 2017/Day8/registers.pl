#!/usr/local/bin/perl
use warnings;
use strict;

my @instr;
my %regs;
my @rKeys;
my $max = 0;
my $runMax = 0;
my $r1 = '';
my $r2 = '';
my $op1 = '';
my $op2 = '';
my $val1 = 0;
my $val2 = 0;
my $ifText;

open (MYFILE,"<input.txt") or die "Can't open input file: $!";
#open (MYFILE,"<test.txt") or die "Can't open test file: $!";

# Read in the instruction list
while(<MYFILE>) {
	chomp($_);
	push(@instr,$_);	
}

close(MYFILE);

# Run through all the instructions once
for(my $i=0;$i<scalar(@instr);$i++) {
	($r1,$op1,$val1,$ifText,$r2,$op2,$val2) = split(" ",$instr[$i]);
	
	# if registers have not yet been defined, initalize to 0
	if ( !(defined $regs{$r1}) ) {	$regs{$r1} = 0;	}
	if ( !(defined $regs{$r2}) ) {	$regs{$r2} = 0; }
	
	if ( conditional($r2,$op2,$val2,\%regs) ) {
		# Increase or Decrease Reg1
		if ($op1 eq 'inc') {
			$regs{$r1} = $regs{$r1} + $val1;
		} elsif ($op1 eq 'dec') { 
			$regs{$r1} = $regs{$r1} - $val1;
		} else {
			die "Something wrong with first operator: $op1\n";
		}
	} # End conditional If
	
	# Find the max register value during runtime	
	if ($regs{$r1} > $runMax) {
		$runMax = $regs{$r1};
	}
} # End for loop

# Find the largest register value
@rKeys = keys %regs;

foreach my $k (@rKeys) {
	if ($regs{$k} > $max) {
		$max = $regs{$k};
	}
}

print "The max during runtime is $runMax\n";
print "The maximum value in the registers is: $max\n";

exit 0;
#====================== End Main Section =============================

# Check the contidional of the instruction and return a bool value
sub conditional {
	(my $r, my $op, my $v, my $hRef) = @_;
	
	if($op eq '>') {
		if ($hRef->{$r} > $v) {
			return 1;
		}
	} elsif ($op eq '<') {
		if ($hRef->{$r} < $v) {
			return 1;
		}
	} elsif ($op eq '>=') {
		if ($hRef->{$r} >= $v) {
			return 1;
		}
	} elsif ($op eq '<=') {
		if ($hRef->{$r} <= $v) {
			return 1;
		}
	} elsif ($op eq '==') {
		if ($hRef->{$r} == $v) {
			return 1;
		}
	} elsif ($op eq '!=') {
		if ($hRef->{$r} != $v) {
			return 1;
		}
	} else {
		die "Something is wrong with the second operator: $op\n";
	}
	
	return 0;
} # End conditional
