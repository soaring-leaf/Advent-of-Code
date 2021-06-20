#!/usr/local/bin/perl
use warnings;
use strict;

my $mcle = '';
my @subs;
my @newMols;
my $element = '';
my $rep = '';

open (MYFILE,"<input.txt") or die "Couldn't open file: $!";

while (<MYFILE>) {
	chomp($_);
	push(@subs,$_);
}

close(MYFILE);

# Get the molecule from the end of the list and pop the blank line off the end
$mcle = pop(@subs);
pop(@subs);

for(my $i=0;$i<scalar(@subs);$i++) {
	($element,$rep) = split(' => ',$subs[$i]);
	
	
}

print "Number of new molecules created is ".scalar(@newMols)."\n";

exit 0;
#====================== End Main Section =============================

