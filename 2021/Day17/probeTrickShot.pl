#!/usr/bin/perl
use warnings;
use strict;

my $minX = 281; # X range Targeting Area
my $maxX = 311;
my $minD = -54; # Depth range Targeting Area
my $maxD = -74;
my $initX = 0; # Initial X Velocity
my $initY = 0; # Initial Y Velocity
my $bestVelY = 0; # highest Y Velocity Launch while hitting Target Area

# Scenarios where Probe will never hit:
#   - if x velocity = 0 and < minX
#   - if curr X position is > maxX
#   - if curr depth position <deeper than> $maxD

# Part 1:

# First find minimum X Velocity to get within targeting area (stops moving above it and will fall through)

# progress higher 
print "Highest Launch while hitting Target Area: $bestVelY\n";

# Part 2:

#print "\n\n";

exit(0);
#==========================================================================
