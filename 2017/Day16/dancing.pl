#!/usr/local/bin/perl
use warnings;
use strict;

my @line = ('a' .. 'p');
my $instr = '';
my $i = 0;
my $k = 0;
my $dateTime = localtime();
my $cycle = 0;
my $notFound = 1;

print "$dateTime\n";

open(MYFILE,"<input.txt") or die "Can't open input file: $!";

while(<MYFILE>) {
	chomp($_);
	$instr = $_;
}

close(MYFILE);

# Run the line of Dancers through a 'billion' times
# Finding the dancers cycle back to their starting position after 60 iterations
# of the dance, we just need to run through 40 times to simulate a billion cycles
for(my $c=0;$c<40;$c++) {
#while($notFound) {
#	$cycle++;
	$i = 0;

while ($i < length($instr)) {
	#print "i is $i and length of instructions\n  is ". length($instr) . "\n\n\n";
	my $step = '';
	my $move = '';
	my $prog = '';
	
	$k = index($instr,',',$i);
	
	if($k > 0) {
		$step = substr($instr,$i,$k-$i);
	} else {
		$step = substr($instr,$i);
	}
	
	$move = substr($step,0,1);
	$step = substr($step,1);
	
	if($move eq 's') {
		my $dancers = join('',@line);
		$dancers = substr($dancers,($step * -1)) . substr($dancers,0,(length($dancers)-$step));
		@line = split('',$dancers);
#		for(my $d=0;$d<$step;$d++) {
#			$prog = pop(@line);
#			unshift(@line,$prog);
#		}
	} else {
		my $pos = index($step,'/');
		my @s; # = split('/',$step);
		$s[0] = substr($step,0,$pos);
		$s[1] = substr($step,$pos+1);
		if($move eq 'p') {
			for(my $e=0;$e<scalar(@line);$e++) {
				if($line[$e] eq $s[0]) {
					$s[0] = $e;
				}
				if($line[$e] eq $s[1]) {
					$s[1] = $e;
				}
			}
		}
		
		$prog = $line[$s[0]];
		$line[$s[0]] = $line[$s[1]];
		$line[$s[1]] = $prog;		
	} 
		
	if($k < 0) {
		$i = length($instr);
	} else {
		$i = $k + 1;
	}
} #end while to process dance sequence

# to find how many iterations of the dance before back to start
#if(join('',@line) eq 'abcdefghijklmnop') {
#	$notFound--;
#}

} #end for loop counting 'a billion' cycles of the sequence

$dateTime = localtime();
print "$dateTime\n";

# Print the order at the end
foreach my $e (@line) {
	print "$e";
}

#print " is back after $cycle cycles.\n";

exit 0;
#====================== End Main Section =============================


