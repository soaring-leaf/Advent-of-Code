#!/usr/bin/perl
use warnings;
use strict;

my $overLap = 0; # count of overlapping cleaning assignments
my @assigns; # Array to hold each assignment pair

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    push(@assigns,$_);
    
    my ($e1,$e2) = split(',');

    my ($e1St, $e1Fin) = split('-',$e1);
    my ($e2St, $e2Fin) = split('-',$e2);
    
    if(($e1St >= $e2St && $e1Fin <= $e2Fin) || ($e2St >= $e1St && $e2Fin <= $e1Fin)) {
        $overLap++;
    }
}

close(INPUT);

print "There are $overLap Elves that have overlapping areas.\n\n";

# Part 2 - 

exit(0);
#==========================================================================
sub getCommonItem {
    my ($c1,$c2) = @_;

    my @check = split('',$c1);

    for(my $i=0;$i<scalar(@check);$i++) {
        if(index($c2,$check[$i]) >= 0) {
            return $check[$i];
        }
    }

    return '-';
}

sub getBadge {
    my ($b1,$b2,$b3) = @_;

    my @bCheck = split('',$b1);

    for(my $i=0;$i<scalar(@bCheck);$i++) {
        if(index($b2,$bCheck[$i]) >= 0 && index($b3,$bCheck[$i]) >= 0) {
            return $bCheck[$i];
        }
    }

    return '-';
}

sub getPriority {
    my $c = $_[0];
    my $p = ord(lc($c)) - 96;

    if(ord($c) < 91) {
        $p += 26
    }
    return $p;
}