#!/usr/local/bin/perl
use warnings;
use strict;
use Data::Dumper;

my @pad;
my @instr;
my $lit = 0;

initPad(\@pad);

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";
#open (MYFILE,"<test.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	@instr = split(' ',$_);
	
	if ($instr[0] eq 'rect') {
		processRect(\@pad,$instr[1]);
	} elsif ($instr[0] eq 'rotate') {
		shift(@instr);
		processRotate(\@pad,@instr);		
	} else {
		die "something went wrong with input, not 'rect' or 'rotate'";
	}
	
} # end while loop

close MYFILE;

#print Dumper @pad;

$lit = countPixels(\@pad);
printPad(\@pad);

print "Number of lit pixels should be $lit\n";

exit 0;
#====================== End Main Section =============================
sub printPad {
	my $p = shift;
	
	open(OUTPUT,">out.txt") or die "can't open output file: $!";
	
	for (my $r=0;$r<6;$r++) {
		for (my $c=0;$c<50;$c++) {
			if ($p->[$c][$r] == 1) {
				print OUTPUT 'X';
			} else {
				print OUTPUT ' ';
			}
		}
		print OUTPUT "\n";
	}
	
	close(OUTPUT);
}

sub countPixels {
	my $p = shift;
	my $n = 0;
	
	for (my $c=0;$c<50;$c++) {
		for (my $r=0;$r<6;$r++) {
			if ($p->[$c][$r] == 1) {
				$n++;
			} 
		}
	}
	
	return $n;	
}

sub processRotate {
	my $p = shift;
	my @i = @_;
	my @line;
	my @shift;
	my $iNum = substr($i[1],2);
	my $rNum = pop(@i);
	
	if ($i[0] eq 'row') {
		#get the row in an array from the pad
		for (my $c=0;$c<50;$c++) {
			push(@line,$p->[$c][$iNum]);
		}
		
		#rotate row
		$rNum = 0 - $rNum;
		@shift = splice(@line,$rNum);
		splice(@line,0,0,@shift);
		
		#put row back on pad
		for (my $c=0;$c<50;$c++) {
			$p->[$c][$iNum] = $line[$c];
		}
		
	} else {
		@line = @{$p->[$iNum]};
		$rNum = 0 - $rNum;
		@shift = splice(@line,$rNum);
		splice(@line,0,0,@shift);
		$p->[$iNum] = \@line;
	}
	
}

sub processRect {
	my $p = shift;
	my $i = shift;
	my @g = split('x',$i);
	
	for (my $c=0;$c<$g[0]; $c++) {
		for (my $r=0;$r<$g[1];$r++) {
			$p->[$c][$r] = 1;
		}
	}
}

sub initPad {
	my $p = shift;
	
	for (my $i=0;$i<50;$i++) {
		my @c = (0) x 6;
		push(@{$p},\@c);
	}
}

