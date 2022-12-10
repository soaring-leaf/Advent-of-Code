#!/usr/bin/perl
use warnings;
use strict;

my $x = 1; # X register
my $cycle = 0; # Cycle counter
my @instr; # Array holding the program instructions
my $sigStrength = 0; # Sum of the critical cycle signals

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    push(@instr,$_);

    $cycle++;

    if(cycleCheck($cycle) == 1) {
        $sigStrength += $cycle * $x;
    }

    if($_ ne 'noop') {
        $cycle++;
        if(cycleCheck($cycle) == 1) {
            $sigStrength += $cycle * $x;
        }

        my($add, $num) = split(' ');

        $x += $num;
    }
}

close(INPUT);

print "Sum of the critical cycle signals: $sigStrength\n\n";

exit(0);
#==========================================================================
sub cycleCheck {
    my $c = $_[0];

    if(($c-20) % 40 == 0) {
        return 1;
    } else {
        return 0;
    }

}