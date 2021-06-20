#!/usr/local/bin/perl
use warnings;
use strict;

my $prnt = '';
my @progs;
my %pipes;
my %commGroup;
my @line;
my $group = 0;

open(MYFILE,"<input.txt") or die "Can't open input file: $!";

while(<MYFILE>) {
	chomp($_);
	@line = split(" <-> ");
	
	$prnt = shift(@line);			
	push(@progs,$prnt);
	
	$pipes{$prnt} = $line[0];	
}

close(MYFILE);

# Part 1
#============================================
#$commGroup{0} = 1;

#findGroup(0,\%pipes,\%commGroup);

#@line = keys %commGroup;
#$group = scalar(@line);

#print "There are $group programs in the connected group\n";
#============================================

# Part 2
#============================================
for (my $k=0;$k<2000;$k++) {
	if (!exists $commGroup{$k}) {
		findGroup($k,\%pipes,\%commGroup);
		$group++;
	}
}

print "There are $group groups in the whole village\n";

exit 0;
#====================== End Main Section =============================

# Run through all the connections between programs in the current group
sub findGroup {
	(my $e, my $pHash, my $cHash) = @_;
	my @items = split(", ",$pHash->{$e});
	
	# need to check each item for known connectivity
	foreach my $i (@items) {
		if(!exists $cHash->{$i}) {
			$cHash->{$i} = 1;
			findGroup($i,$pHash,$cHash);
		}
	}
	
	return;
} # End findGroup
