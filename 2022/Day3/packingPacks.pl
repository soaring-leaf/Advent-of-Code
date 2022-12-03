#!/usr/bin/perl
use warnings;
use strict;

my $pTotal = 0; # Sum for Priority totals
my $bTotal = 0; # Sum for Badge Priority totals
my $count = 0; # count of packs
my @packs; # Array to hold contents of each pack for Part2

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    chomp;

    push(@packs,$_);

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

# Part 2 - Find badges and Priorities
for(my $i=0;$i<scalar(@packs);$i+=3) {
    my $badge = getBadge($packs[$i],$packs[$i+1],$packs[$i+2]);
    $bTotal += getPriority($badge);
}

print "Badge Priority total is $bTotal\n";

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