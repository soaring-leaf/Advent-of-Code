#!/usr/local/bin/perl

use strict;
use warnings;
use Data::Dumper;

my @a = (0,1,2,3,4,5);
my @b = (6,7,8,9);

splice(@b,0,0,@a);

print Dumper @b;

exit(0);
