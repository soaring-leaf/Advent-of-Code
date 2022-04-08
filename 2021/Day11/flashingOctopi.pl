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

    for(my $r=0; $r < 10; $r++) {
        for(my $c=0; $c < 10; $c++) {
            $grid->[$r][$c]++;
        }
    }
}

# Takes OctopiGrid and processes the flashes
sub countFlashes {
    my $count = 0;
    my @grid = @{$_[0]};
    my @copyGrid = @{copyOctos($_[0])}; # copy of octoGrid to process the flashes
    my $transferArr1; # Array Reference to transfer the copy array to the grid var
    my $transferArr2; # Array Reference to transfer the copy array to the grid var
    my $flashFlag = -1; # Flag indicating found flashes, need to go over the grid again

    # for each grid position, if octo is 10+, update the surrounding octos in Copy
    # BUT not if the adjacent octo is at 0 and flag if a flash is detected
    # run through again and update any flashed octos to 0
    # if flagged, run through above again.

    while($flashFlag > 0 || $flashFlag == -1) {
        $flashFlag = 0;

        print "copy of grid: \n";
        printSteps(\@copyGrid);

        for(my $r=0; $r < 10; $r++) {
            for(my $c=0; $c < 10; $c++) {
                if($grid[$r][$c] > 9) {
                    $flashFlag++;
                    $count++;
                    $grid[$r][$c] = 0;
                    $copyGrid[$r][$c] = 0;

                    if($r > 0) {
                        if($copyGrid[$r-1][$c] != 0) {
                            $copyGrid[$r-1][$c]++;
                        }
                        if($c > 0) {
                            if($copyGrid[$r-1][$c-1] != 0) {
                                $copyGrid[$r-1][$c-1]++;
                            }
                        }
                        if($c < 9) {
                            if($copyGrid[$r-1][$c+1] != 0) {
                                $copyGrid[$r-1][$c+1]++;
                            }
                        }
                    }

                    if($c > 0) {
                        if($copyGrid[$r][$c-1] != 0) {
                            $copyGrid[$r][$c-1]++;
                        }
                    }
                    if($c < 9) {
                        if($copyGrid[$r][$c+1] != 0) {
                            $copyGrid[$r][$c+1]++;
                        }
                    }

                    if($r < 9) {
                        if($copyGrid[$r+1][$c] != 0) {
                            $copyGrid[$r+1][$c]++;
                        }
                        if($c > 0) {
                            if($copyGrid[$r+1][$c-1] != 0) {
                                $copyGrid[$r+1][$c-1]++;
                            }
                        }
                        if($c < 9) {
                            if($copyGrid[$r+1][$c+1] != 0) {
                                $copyGrid[$r+1][$c+1]++;
                            }
                        }
                    }
                }
            }
        }

        $transferArr1 = \@copyGrid;
        $transferArr2 = \@grid;

        @grid = @{$transferArr1};
        @copyGrid = @{$transferArr2};
    }

    # return updated grid and total number of flashes for this entire step
    return (\@grid,$count);
}

sub copyOctos {
    my @grid = @{$_[0]};
    my @newcopy;

    for(my $r=0; $r < 10; $r++) {
        my @col = @{$grid[$r]};
        push(@newcopy,\@col);
    }

    return \@newcopy;
}

sub printSteps {
    my @oGrid = @{$_[0]};

    for(my $r=0; $r < 10; $r++) {
        for(my $c=0; $c < 10; $c++) {
            print $oGrid[$r][$c];
        }
        print "\n";
    }
    print "\n\n";
}