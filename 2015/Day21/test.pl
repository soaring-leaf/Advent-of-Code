#!usr/local/bin/perl
use warnings;
use strict;
use Data::Dumper;

my @s = ();

push(@s,sub1());
push(@s,sub2());
push(@s,sub1());

print Dumper(\@s);

exit (0);

sub sub1 {
	return ('1','2','3','4');
}

sub sub2 {
	return ('5','6');
}
