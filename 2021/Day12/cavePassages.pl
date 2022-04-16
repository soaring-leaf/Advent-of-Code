#!/usr/bin/perl
use warnings;
use strict;

my %caveConnections; # List of all the passages between rooms in cave
my $pathCount = 0; # count of viable paths

open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
#open(INPUT,"<","testInput.txt") or die "Can't open Test Input file $!";

while(<INPUT>) {
    chomp;
    my ($first, $second) = split('-',$_);

    # Start is one way out, no need to build paths FROM End
    
    # if first time seeing room, create array and add to hash for path
    # otherwise, add the room to the array
    if($first ne 'end' && $second ne 'start') {
        if(!exists($caveConnections{$first})) {
            my @newPath = ($second);
            $caveConnections{$first} = \@newPath;
        } else { 
            push(@{$caveConnections{$first}},$second);
        }
    }

    # do for both directions
    if($first ne 'start' && $second ne 'end') {
        if(!exists($caveConnections{$second})) {
            my @otherPath = ($first);
            $caveConnections{$second} = \@otherPath;
        } else {
            push(@{$caveConnections{$second}},$first);
        }
    }
}

close(INPUT);

# sort each connection array so 'end' is last (desc)
foreach my $k (keys %caveConnections) {
    my @sorted = sort {lc($b) cmp lc($a)} @{$caveConnections{$k}};
    $caveConnections{$k} = \@sorted;
    #print "$k: ";
    #printPath($caveConnections{$k}); # connections list
}

print "\n\n";

$pathCount = traverseCave(\%caveConnections,['start']);

# Part 1 answer:
print "There are $pathCount paths through the cave.\n\n";

# Part 2 answer:
print "\n\n";

exit(0);
#==========================================================================
sub printPath {
    foreach my $e (@{$_[0]}) {
        print "$e ";
    }
    print "\n";
}

# Recursive function to find a path through the cave given a starting room and
# the current path already taken. 
# If End is reached return 1, if no path is available, return 0
sub traverseCave {
    my $pCount = 0; # count of paths calculated
    my $roomHashRef = $_[0]; # reference to the room hash
    my @currPath = @{$_[1]}; # Current path already taken
    my $currRoom = $currPath[scalar(@currPath)-1]; # current Room

    # protect code from runaway recursion
    if(scalar(@currPath) > 15) {
        print "Panic! Something is wrong!\n";
        printPath(@currPath);
        return 0; 
    }

    # for each connection in the current room:
    # 1. check size and if small room, see if it's already been visited
    # 2. if so, skip it and check next one
    # 3. if ok to visit, push it on the current Path array and recurse (add returned result to path Count)
    # 4. if no more rooms are available to visit, return pCount (end of options)
    # 5. if 'end' is found, (don't) print path and add 1 to pCount

    foreach my $r (@{$roomHashRef->{$currRoom}}) {
        my $checkFlag = 0; # Flag to see if a small room is already in the path

        if($r eq 'end') {
            #push(@currPath,'end');
            #printPath(\@currPath);
            #pop(@currPath);

            $checkFlag++; # Found end, nowhere else to go
            $pCount++;
        }

        if($r eq lc($r) && $r ne 'end') {
            foreach my $p (@currPath) {
                if($r eq $p) {
                    $checkFlag++;
                }
            }
        }

        if(!$checkFlag) {
            push(@currPath,$r); # add next room to path and recurse

            $pCount += traverseCave($roomHashRef,\@currPath);

            pop(@currPath); # remove this room from the path to try the next available room in the list
        }
    }

    return $pCount;
}