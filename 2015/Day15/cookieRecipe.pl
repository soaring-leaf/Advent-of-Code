#!/usr/local/bin/perl
use warnings;
use strict;

# Ingredient properties: 
    # Capacity | Durability | Flavor | Texture | Calories
my @sprnkls =  {2,0,-2,0,3};
my @btrsctch = {0,5,-3,0,3};
my @choco =    {0,0,5,-1,8};
my @candy =    {0,-1,0,5,8};

my $maxScore = 0;

# How to iterate across combinations?
# 4 buckets (ingredients) with 100 units

# must have at least one butterscotch (durability)
    # can have up to 4 candy with each butterscotch
# must have at least one candy (Texture)
    # can have up to 4 chocolate with each candy
# must have at least one chocolate (flavor)
    # can have two sprinkles or one sprinkle and a butterscotch per chocolate
# must have at least one sprinkles (Capacity)

print "Best cookie has $maxScore points.\n";

exit 0;
#====================== End Main Section =============================