#!/usr/bin/perl
use warnings;
use strict;

my @stackInput; # saves the initial Stack setup to process later
my @instr; # holds the steps to move all the crates
my @stacks; # 2-D array holding the stacks
my $topCrates = ''; # holds the top crates at the end
my $stackFlag = 0; # 0 = reading stacks, 1 = found instructions

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    if(length($_) > 0) {
        if($stackFlag == 0) {
            if(substr($_,1,1) eq '1') {
                $stackFlag++;
            } else {
                push(@stackInput,$_);
            }
        } else {
            push(@instr,$_);
        }
    }
}

close(INPUT);

# Initalize 2-D array for stacks
for my $i (0 .. 8) {
    my @s;
    push(@stacks,\@s);
}

while(scalar(@stackInput) > 0) {
    my $crates = pop(@stackInput);
    
    my $s = 0; # stack counter
    for(my $e=1; $e<37; $e+=4) {
        my $char = substr($crates,$e,1);
        if($char ne ' ') {
            push(@{$stacks[$s]},$char);
        }

        $s++;
    }
}

print "There are " . scalar(@instr) . " instructions. \n";

for(my $s=0; $s<scalar(@instr); $s++) {
    my $step = $instr[$s];
    my ($j1,$count,$j2,$from,$j3,$to) = split(' ',$step);

    # adjust stack numbers to align to array
    $from--;
    $to--;

    my @moves; # array holding the moving crates
    
    while($count > 0) {
        push(@moves,pop(@{$stacks[$from]}));
        $count--;
    }

    push(@{$stacks[$to]},@moves);
}

for(my $k=0; $k < scalar(@stacks); $k++) {
    my $ch = pop(@{$stacks[$k]});

    if($ch ne ' ') {
        $topCrates = $topCrates . $ch;
    }
}

print "Crates on top of each stack are: $topCrates\n";

exit(0);
#==========================================================================
