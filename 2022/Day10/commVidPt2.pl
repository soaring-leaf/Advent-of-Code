#!/usr/bin/perl
use warnings;
use strict;

my $x = 1; # X register
my $cycle = 0; # Cycle counter
my @crtRow = ('.') x 40; # Array for the CRT screen row to start
my $pos = 0; # Position of the CRT curser during the cycle

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    $cycle++;

    $pos = ($cycle - 1) % 40;

    if(writeOnSpriteCheck($pos,$x) == 1) {
        $crtRow[$pos] = '#';
    }

    if($cycle % 40 == 0) {
        printCRT(\@crtRow);
        @crtRow = ('.') x 40;
    }

    if($_ ne 'noop') {
        $cycle++;
        $pos = ($cycle - 1) % 40;

        if(writeOnSpriteCheck($pos,$x) == 1) {
            $crtRow[$pos] = '#';
        }

        if($cycle % 40 == 0) {
            printCRT(\@crtRow);
            @crtRow = ('.') x 40;
        }

        my($add, $num) = split(' ');

        $x += $num;
    }
}

close(INPUT);

exit(0);
#==========================================================================
sub writeOnSpriteCheck {
    my ($p, $s) = @_;

    if($p == $s-1 || $p == $s || $p == $s+1) {
        return 1;
    } else {
        return 0;
    }
}

sub printCRT {
    my @crt = @{$_[0]};

    for(my $i=0; $i < scalar(@crt); $i++) {
        print $crt[$i];
    }

    print "\n";
}