#!/usr/bin/perl
use warnings;
use strict;

my $section = 0; # Section of input currently being read
my $err = 0; # Tracks Ticket Error Rate of invalid numbers
my $max = 0; # Max valid number
my $min = -1; # Min valid number - ranges overlap so only need one max/min set
my $invalid = 0; # flag for a valid/invalid ticket
my %fieldOptions = (); # hash to hold the ticket field data
my %validTickets = (); # hash to hold valid tickets
my $ticketCount = 0; # ticket counter for hash key
my $totalTickets = 0; # Total Tickets in Input
my @myTicket = (); # my ticket details


open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";

while(<INPUT>) {
    if(length($_) < 5) { # Blank line, on to next section
        $section++;
    } elsif ($section == 0) { # fields and values
        my ($label,$ranges) = split(': ');
        my ($currMin,$mid,$currMax) = split('-',$ranges);
        my ($range1Max,$range2Min) = split(' or ',$mid);

        my @dataRanges = ($currMin,$range1Max,$range2Min,$currMax);
        $fieldOptions{$label} = \@dataRanges;

        if($min == -1 || $min > $currMin) {
            $min = $currMin;
        }
        
        if ($max < $currMax) {
            $max = $currMax;
        }
    } elsif($section == 1) { # My Ticket info
        @myTicket = split(',');
    } else { # All the other ticket values
        my @currTicket = split(',');

        if(scalar(@currTicket) > 1) {
            $totalTickets++;
            # tabulate Errors in Ticket Scanning (Part 1)
            for (my $i=0;$i<scalar(@currTicket);$i++) {
                if($currTicket[$i] < $min || $currTicket[$i] > $max) {
                    $err += $currTicket[$i];
                    $invalid++;
                }
            }
            
            # if it's a valid ticket, add it to the valid ticket hash
            if(!$invalid) {
                $validTickets{$ticketCount} = \@currTicket;
                $ticketCount++;
            }
        }
    }

    $invalid = 0; # reset invalid ticket flag
}

close(INPUT);

print "There are $ticketCount valid tickets out of $totalTickets. \n";

# Part 1 answer:
print "Ticket scanning Error Rate is $err \n";

# Part 2: Use built hashes to figure out which field is which
my %currPossible = (); # hash for current possible options the field could be
my @solution = (); # array identifying the field position

exit(0);
#==========================================================================
