#!/usr/bin/perl
use warnings;
use strict;

my $calibrationSumPt1 = 0; # Sum of all the Calibration Lines for initial puzzle
my $calibrationSumPt2 = 0; # Sum of all the Calibration Lines after updated info
my @numWords = ('five','four','six','seven','nine','three','eight','two','one');
# both 3 and 8 run into each other
# if 9 is not close to 7, it can be replaced
# same for 1 and 2
# 9 and 3 are chained to 8
# 8 is chained to 3 and 2

my %wordToNum = (
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9,
);
    
open(INPUT,"<","inputTest.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;
    print "current read in: $_\n";
    my $currLinePt1 = $_;

    my $currLinePt2 = subNumsForWords($_,\@numWords,\%wordToNum);

    $currLinePt1 =~ s/\D//g;
    $currLinePt2 =~ s/\D//g;
    print "currLine1: $currLinePt1\n";
    print "currLine2: $currLinePt2\n";

    $calibrationSumPt1 += (substr($currLinePt1,0,1) * 10) + substr($currLinePt1,-1);
    $calibrationSumPt2 += (substr($currLinePt2,0,1) * 10) + substr($currLinePt2,-1);
}

close(INPUT);

print "Part 1 - Calibration Total: " . $calibrationSumPt1 . "\n";

# Part 2 - 

print "Part 2 - Calibration Total: " . $calibrationSumPt2 . "\n";

exit(0);
#==========================================================================
sub subNumsForWords {
    my $str = $_[0];

    my @numWords = @{$_[1]};
    my %wordToNum = %{$_[2]};
    my $numWordsRemain = 1;
    my @wordCount = (0) x 9;

    findNumWords($str,\@wordCount,\@numWords);

    for(my $i=0; $i < 9; $i++) {
        if($wordCount[$i] != -1) {
            $str =~ s/$numWords[$i]/$wordToNum{$numWords[$i]}/;

            if($numWords[$i] == 'seven') {
                $i = 9;
            } elsif ($i == 2) {
                $i += 3;
            }
        }
    }

    print "One Round Sub: $str\n";

    return $str;
}

sub findNumWords {
    my $s = $_[0];
    my $searchResult = $_[1];
    my @words = @{$_[2]};
    
    for(my $i=0;$i < 9; $i++) {
        $searchResult->[$i] = index($s,$words[$i]);
    }
}
