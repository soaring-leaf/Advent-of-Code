#!/usr/bin/perl
use warnings;
use strict;

my $pTotal = 0; # Sum for Priority totals
my $count = 0; # count of packs

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    my $len = length($_);

    my $comp1 = substr($_,0,$len/2);
    my $comp2 = substr($_,$len/2);
    
    my $item = getCommonItem($comp1,$comp2);
    #print "$comp1\n$comp2";
    #print "\t $item  -  " . ord($item);

    if($item ne '-') {
        $pTotal += getPriority($item);
    }

    $count++;
}

close(INPUT);

print "For $count packs, Total priority score is $pTotal\n";

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

sub getPriority {
    my $c = $_[0];
    my $p = ord(lc($c)) - 96;

    if(ord($c) < 91) {
        $p += 26
    }
    return $p;
}