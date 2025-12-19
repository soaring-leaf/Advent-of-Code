#!/usr/bin/perl
use warnings;
use strict;

my $safeReports = 0; # Count of safe reports
my $safeDampenerReports = 0; # Count of safe reports with Dampener

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    my @rptData = split(' ',$_);
    my $isSafe = 0; # Is the report safe?
    my $dup = 0; # incremented if duplicate is found at head of report
    
    if($rptData[0] < $rptData[1]) {
        $isSafe = checkRising(\@rptData);
    } elsif($rptData[0] > $rptData[1]) {
        $isSafe = checkFalling(\@rptData);
    } else {
        shift(@rptData);
        $dup = 1;
    }

    if($isSafe) {
        $safeReports += $isSafe;
        $safeDampenerReports++;
    } else {
        $isSafe = checkRisingWithDampener(\@rptData,$dup);
        if(!$isSafe) {
            $isSafe = checkFallingWithDampener(\@rptData,$dup);
        }

        $safeDampenerReports += $isSafe;
    }
}

close(INPUT);

# Part 1  -
print "Part 1 - Number of Safe Reports: " . $safeReports . "\n";

# Part 2 - 
print "Part 2 - Number of Safe Reports with Dampener: " . $safeDampenerReports . "\n";

exit(0);
#==========================================================================
sub checkRising {
    my @data = @{$_[0]};

    for(my $r = 0; $r < scalar(@data)-1; $r++) {
        if(($data[$r] >= $data[$r+1]) || (($data[$r+1] - $data[$r]) > 3)) {
            return 0;
        }
    }

    return 1;
}

sub checkFalling {
    my @data = @{$_[0]};

    for(my $f = 0; $f < scalar(@data)-1; $f++) {
        if(($data[$f] <= $data[$f+1]) || (($data[$f] - $data[$f+1]) > 3)) {
            return 0;
        }
    }

    return 1;
}

sub checkRisingWithDampener {
    my @data = @{$_[0]};
    my $dampener = $_[1];
    my $len = scalar(@data);

    for(my $r = 0; $r < $len-1; $r++) {
        if($dampener == 0) {
            if(($data[$r] >= $data[$r+1]) || (($data[$r+1] - $data[$r]) > 3)) {
                if($r+2 < $len && (($data[$r] >= $data[$r+2]) || (($data[$r+2] - $data[$r]) > 3))) {
                    $dampener++;
                    $r++;
                } else {
                    return 0;
                }
                
            }
        } elsif($dampener == 1 && (($data[$r] >= $data[$r+1]) || (($data[$r+1] - $data[$r]) > 3))) {
            return 0;
        }
    }

    return 1;
}

sub checkFallingWithDampener {
    my @data = @{$_[0]};
    my $dampener = $_[1];
    my $len = scalar(@data);

    for(my $f = 0; $f < $len-1; $f++) {
        if($dampener == 0) {
            if(($data[$f] <= $data[$f+1]) || (($data[$f] - $data[$f+1]) > 3)) {
                if($f+2 < $len && (($data[$f] <= $data[$f+2]) || (($data[$f] - $data[$f+2]) > 3))) {
                    $dampener++;
                    $f++;
                } else {
                    return 0;
                }
            }
        } elsif($dampener == 1 && (($data[$f] <= $data[$f+1]) || (($data[$f] - $data[$f+1]) > 3))) {
            return 0;
        }
    }

    return 1;
}