#!/usr/bin/perl
use warnings;
use strict;

my %trees; # Hash holding the coords of visible trees
my @treeMap; # 2-D array mapping the trees
my $rowCount = 0; # Num of Trees in each row

####
# something is wrong, Ans: 1918 is too high
####

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    my @r = split('');
    push(@treeMap,\@r);
    $rowCount = scalar(@r);
}

close(INPUT);

markFirstLastRows(\%trees,$rowCount);

viewEW(\%trees,\@treeMap);

viewNS(\%trees,\@treeMap);

print "Number of visible trees from the edges: " . keys(%trees) . "\n";

# Part 2 - 

exit(0);
#==========================================================================
sub markFirstLastRows {
    my ($tRef, $num) = @_;
    my $last = $num - 1;

    for(my $k=0; $k<$num; $k++) {
        $tRef->{"0,$k"} = 1;
        $tRef->{"$last,$k"} = 1;
    }
}

sub findTallest {
    my @row = @{$_[0]};
    my $tall = $row[0];

    for(my $i=1; $i < scalar(@row); $i++) {
        if($row[$i] > $tall) {
            $tall = $row[$i];
        }
    }

    return $tall;
}

sub viewEW {
    my ($visTreesRef, $mapRef) = @_;
    my @tMap = @{$mapRef};
    my $tallHeight = 0; # Tallest Tree in Row

    for(my $row=0; $row < scalar(@tMap); $row++) {
        my @treeRow = @{$tMap[$row]};
        my $currHeight = -1;
        
        if($row > 0 || $row < scalar(@tMap)-1) {
            $tallHeight = findTallest(\@treeRow);
        }

        # check view from left
        for(my $left=0; $left < scalar(@treeRow); $left++) {
            if($treeRow[$left] > $currHeight) {
                $visTreesRef->{"$row,$left"} = 1;
                $currHeight = $treeRow[$left];

                if($currHeight == $tallHeight) {
                    $left = scalar(@treeRow);
                }
            }
        }

        $currHeight = -1;

        # check view from right
        for(my $right=scalar(@treeRow)-1; $right > 0; $right--) {
            if($treeRow[$right] > $currHeight) {
                $visTreesRef->{"$row,$right"} = 1;
                $currHeight = $treeRow[$right];

                if($currHeight == $tallHeight) {
                    $right = 0;
                }
            }
        }
    }
}

sub viewNS {
    my ($visTreesRef, $mapRef) = @_;
    my @tMap = @{$mapRef};
    my $tallHeight = 0; # Tallest Tree in Column
    my $currHeight = -1;
    my @col; # Array to hold the columns

    for(my $c=1; $c<scalar(@tMap)-1; $c++) {
        for(my $r=0; $r<scalar(@tMap); $r++) {
            push(@col,$tMap[$r][$c]);
        }

        $tallHeight = findTallest(\@col);

        # check view from top
        for(my $top=0; $top < scalar(@col); $top++) {
            if($col[$top] > $currHeight) {
                $visTreesRef->{"$top,$c"} = 1;
                $currHeight = $col[$top];

                if($currHeight == $tallHeight) {
                    $top = scalar(@col);
                }
            }
        }

        $currHeight = -1;

        # check view from bottom
        for(my $bot=scalar(@col)-1; $bot > 0; $bot--) {
            if($col[$bot] > $currHeight) {
                $visTreesRef->{"$bot,$c"} = 1;
                $currHeight = $col[$bot];

                if($currHeight == $tallHeight) {
                    $bot = 0;
                }
            }
        }
    }
}