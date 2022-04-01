#!/usr/bin/perl
use warnings;
use strict;

my $errorScore = 0; # Sum for the Error Points
my $corrupted = 0; # Counter for the Corrupted lines
my $incomplete = 0; # Counter for the Incomplete lines
my @linesToFix; # Array to hold the incomplete lines to auto-complete
my @fixedScore; # Array to hold the score of each fixed line
my $lineCount = 0; # Counter for the lines of input
my $medianScore = 0; # Var to hold the Median value of the fixed lines

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    $lineCount++;

    chomp;
    my @line = split('',$_);
    my $len = length($_);
    my @checker; # Array to hold the open chunks
    my $cFlag = 0; # Corrupted Flag

    for(my $i=0; $i < $len; $i++) {
        my $ch = $line[$i];
        
        if($ch eq '(' || $ch eq '[' || $ch eq '{' || $ch eq '<') {
            push(@checker,$ch);
        } else {
            # If there's nothing to pull off, a chunk is trying to close, but never opened
            # Or if the current value doesn't close the last open chunk
            if(scalar(@checker) == 0) {
                $cFlag++;
                $corrupted++;
                $i = $len;
            } else {
                my $lastCh = reverseChar(pop(@checker));

                if($lastCh ne $ch) {
                    $cFlag++;
                    $corrupted++;
                    $i = $len;
                }
            }

            # Score the error if corrupted
            if($cFlag) {
                if($ch eq ')') {
                    $errorScore += 3;
                } elsif($ch eq ']') {
                    $errorScore += 57;
                } elsif($ch eq '}') {
                    $errorScore += 1197;
                } else {
                    $errorScore += 25137;
                }
            }
        }
    }

    # check for Incomplete lines
    if(!$cFlag && scalar(@checker) > 0) {
        $incomplete++;
        push(@linesToFix,\@checker); # only need the remaining open chunks
    }
}

close(INPUT);

# run through linesToFix array and score the remaining chunks to close for each line
# Add score to fixedScore array
for(my $i=0; $i < scalar(@linesToFix); $i++) {
    my @arr = @{$linesToFix[$i]};
    my $lineScore = 0;

    while(scalar(@arr) > 0) {
        my $char = reverseChar(pop(@arr));

        $lineScore = $lineScore * 5;
        $lineScore += getCloseChunkScore($char);
    }

    push(@fixedScore,$lineScore);
}

# sort fixedScore array and find median score
@fixedScore = sort {$a <=> $b} @fixedScore;

$medianScore = $fixedScore[(scalar(@fixedScore)-1)/2];

# Part 1 answer:
print "Of all the lines ($lineCount), $incomplete were incomplete and \n";
print "$corrupted were corrupted for a score of $errorScore.\n\n";

# Part 2 answer:
print "The middle score for the incomplete lines is: $medianScore\n\n";

exit(0);
#==========================================================================
sub reverseChar {
    my $c = $_[0];

    if($c eq '(') {
        return ')';
    } elsif($c eq '[') {
        return ']';
    } elsif($c eq '{') {
        return '}';
    } else {
        return '>';
    }
}

sub getCloseChunkScore {
    my $c = $_[0];

    if($c eq ')') {
        return 1;
    } elsif($c eq ']') {
        return 2;
    } elsif($c eq '}') {
        return 3;
    } else {
        return 4;
    }
}