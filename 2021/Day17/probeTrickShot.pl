#!/usr/bin/perl
use warnings;
use strict;

my $minX = 281; # X range Targeting Area
my $maxX = 311;
my $minD = -54; # Depth range Targeting Area
my $maxD = -74;
my $found = 0; # flag to help find Initial X Velocity
my $initX = 0; # Initial X Velocity
my $maxVelX = 0; # Max X velocity while still hitting correct range
my $initY = 0; # Initial Y Velocity
my $bestVelY = 0; # highest Y Velocity Launch while hitting Target Area

# Scenarios where Probe will never hit:
#   - if x velocity = 0 and < minX
#   - if curr X position is > maxX
#   - if curr depth position <deeper than> $maxD

# Part 1:

# First find minimum X Velocity to get within targeting area 
#   (stops moving above it and will fall through)
while($found == 0) {
    $initX++;
    $found = stepThroughX($initX,$minX,$maxX);
}

# Find Max X velocity
$maxVelX = $initX;

while($found == 1) {
    $maxVelX++;
    $found = stepThroughX($maxVelX,$minX,$maxX);
}

# Last attempt fails so adjust Max X Vel
$maxVelX--;

print "Min X velocity to get to target area is: $initX\n";
print "Max possible X Velocity is: $maxVelX\n";

# progress with higher launches until probe pings within target


print "Highest Launch while hitting Target Area: $bestVelY\n";

# Part 2:

#print "\n\n";

exit(0);
#==========================================================================
sub stepThroughX {
    (my $init, my $min, my $max) = @_;
    my $xPos = 0;
    
    for($init; $init>0; $init--) {
        $xPos += $init;
    }
    
    if($xPos < $max && $xPos > $min) {
        return 1;
    } else {
        return 0;
    }
}