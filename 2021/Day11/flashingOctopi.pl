#!/usr/bin/perl
use warnings;
use strict;

my $flashCount = 0; # Count of flashes
my @octopiGrid; # main grid of the energy level for each octopus
my $gridRef; # Reference for returning the octopiGrid
my $stepCount = 0; # count returned for each step

#open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my @line = split('',$_);
    
    push(@octopiGrid,\@line);
}

close(INPUT);

for(my $s=0; $s < 10; $s++) {
    print "Step $s:\n";
    printSteps(\@octopiGrid);

    advanceStep(\@octopiGrid);
    ($gridRef,$stepCount) = countFlashes(\@octopiGrid);

    $flashCount += $stepCount;
    @octopiGrid = @{$gridRef};
}

# Part 1 answer:
print "After 100 steps, there were $flashCount flashes.\n\n";

# Part 2 answer:
print "\n\n";

exit(0);
#==========================================================================
# Takes OctopiGrid and updates each octopus with +1 energy
sub advanceStep {
    my $grid = $_[0];

    for(my $c=0; $c < 10; $c++) {
        for(my $r=0; $r < 10; $r++) {
            $grid->[$c][$r]++;
        }
    }
}

# Takes OctopiGrid and processes the flashes
sub countFlashes {
    my $count = 0;
    my @grid = @{$_[0]};
    my @copyGrid = @{copyOctos($_[0])}; # copy of octoGrid to process the flashes
    my @transferArr; # Array Reference to transfer the copy array to the grid var
    my $flashFlag = -1; # Flag indicating found flashes, need to go over the grid again

    # for each grid position, if octo is 10+, update the surrounding octos in Copy
    # BUT not if the adjacent octo is at 0 and flag if a flash is detected
    # run through again and update any flashed octos to 0
    # if flagged, run through above again.

    while($flashFlag > 0 || $flashFlag == -1) {
        $flashFlag = 0;

        for(my $c=0; $c < 10; $c++) {
            for(my $r=0; $r < 10; $r++) {
                if($grid[$c][$r] > 9) {
                    $flashFlag++;
                    $count++;
                    $grid[$c][$r] = 0;
                    $copyGrid[$c][$r] = 0;

                    if($c > 0) {
                        if($copyGrid[$c-1][$r] != 0) {
                            $copyGrid[$c-1][$r]++;
                        }
                        if($r > 0) {
                            if($copyGrid[$c-1][$r-1] != 0) {
                                $copyGrid[$c-1][$r-1]++;
                            }
                        }
                        if($r < 10) {
                            if($copyGrid[$c-1][$r+1] != 0) {
                                print "$c,$r\n";
                                $copyGrid[$c-1][$r+1]++;
                            }
                        }
                    }

                    if($r > 0) {
                        if($copyGrid[$c][$r-1] != 0) {
                            $copyGrid[$c][$r-1]++;
                        }
                    }
                    if($r < 10) {
                        if($copyGrid[$c][$r+1] != 0) {
                            $copyGrid[$c][$r+1]++;
                        }
                    }

                    if($c < 10) {
                        if($copyGrid[$c+1][$r] != 0) {
                            $copyGrid[$c+1][$r]++;
                        }
                        if($r > 0) {
                            if($copyGrid[$c+1][$r-1] != 0) {
                                $copyGrid[$c+1][$r-1]++;
                            }
                        }
                        if($r < 10) {
                            if($copyGrid[$c+1][$r+1] != 0) {
                                $copyGrid[$c+1][$r+1]++;
                            }
                        }
                    }
                }
            }
        }

        @transferArr = @copyGrid;
        @copyGrid = @grid;
        @grid = @transferArr;

    }

    # return updated grid and total number of flashes for this entire step
    return (\@grid,$count);
}

sub copyOctos {
    my @grid = @{$_[0]};
    my @copy; 

    for(my $c=0; $c < 10; $c++) {
        my @row;
        for(my $r=0; $r < 10; $r++) {
            push(@row,$grid[$c][$r]);
        }
        push(@copy,\@row);
    }

    return \@copy;
}

sub printSteps {
    my @oGrid = @{$_[0]};

    for(my $c=0; $c < 10; $c++) {
        for(my $r=0; $r < 10; $r++) {
            print $oGrid[$c][$r];
        }
        print "\n";
    }
    print "\n\n";
}