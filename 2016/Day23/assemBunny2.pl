#!/usr/local/bin/perl
use warnings;
use strict;

my $a = 12;
my $b = 0;
my $c = 0;
my $d = 0;
my @instr;
my @step;
my $i = 0;
my $count = 0;

#
# NEED TO OPTIMIZE THE ASSEMBUNNY CODE WHERE 
# inc a  
# dec b  
# jnz b - 2
# IS JUST A = A + B, B = 0;
#
# ALSO A MULTIPLICATION OPTIMIZATION TO BE HAD
#

open (MYFILE,"<input2.txt") or die "unable to open file: $!";

while (<MYFILE>) {
	chomp($_);
	push(@instr,$_);
}

close(MYFILE);

print "program is ".scalar(@instr)." instr. long. $a $b $c $d\n";

while ($i < scalar(@instr)) {
	$count++;
	if ($count % 5000000 == 0) {
		print "executed $count instr so far, $a $b $c $d\n";
	}
	
	@step = split(' ',$instr[$i]);
	
	if ($step[0] eq 'inc') {
		if ($step[1] eq 'a') {
			$a++;
		} elsif ($step[1] eq 'b') {
			$b++;
		} elsif ($step[1] eq 'c') {
			$c++;
		} elsif ($step[1] eq 'd') {
			$d++;
		} 
		$i++;
	} elsif ($step[0] eq 'dec') {
		if ($step[1] eq 'a') {
			$a--;
		} elsif ($step[1] eq 'b') {
			$b--;
		} elsif ($step[1] eq 'c') {
			$c--;
		} elsif ($step[1] eq 'd') {
			$d--;
		} 
		$i++;
	} elsif ($step[0] eq 'cpy') {
		if ($step[2] eq 'a') {
			$a = getValue($a,$b,$c,$d,$step[1]);
		} elsif ($step[2] eq 'b') {
			$b = getValue($a,$b,$c,$d,$step[1]);
		} elsif ($step[2] eq 'c') {
			$c = getValue($a,$b,$c,$d,$step[1]);
		} elsif ($step[2] eq 'd') {
			$d = getValue($a,$b,$c,$d,$step[1]);
		}
		$i++;
	} elsif ($step[0] eq 'tgl') {
		toggle($i,getValue($a,$b,$c,$d,$step[1]),scalar(@instr),\@instr);
		print "$a $b $c $d\n";
		$i++;
	} else {
		if (getValue($a,$b,$c,$d,$step[1]) ne 0) {
			if (getValue($a,$b,$c,$d,$step[2]) == 0) {
				$i++;
			} elsif ($i+getValue($a,$b,$c,$d,$step[2]) > 0) {
				$i = $i + getValue($a,$b,$c,$d,$step[2]);
			} else {
				$i++;
			}
		} else {
			$i++;
		}
	}
}

print "Register A is now $a \n";

exit(0);
#====================== End Main Section =============================
sub toggle {
	my $curr = shift;
	my $val = $curr + shift;
	my $prog = shift;
	my $iRef = shift;
	my @i;
	
	print "in toggle, about to update instr at $val, registers are $a $b $c $d\n";
	
	if (($val < 0) || ($val >= 25)) {
		return;
	}
	
	@i = split(' ',$iRef->[$val]);
	
	print "value is $val, prog steps is $prog, about to toggle $iRef->[$val] \n";
	
	if (scalar(@i) == 2) {
		if ($i[0] eq 'inc') {
			$i[0] = 'dec';
		} else {
			$i[0] = 'inc';
		}
	} elsif (scalar(@i) == 3) {
		if ($i[0] eq 'jnz') {
			$i[0] = 'cpy';
		} else {
			$i[0] = 'jnz';
		}
	} else {
		return;
	}
	
	$iRef->[$val] = join(' ',@i);
	print "instr is now $iRef->[$val] ";
	
}
sub getValue {
	my $a = shift;
	my $b = shift;
	my $c = shift;
	my $d = shift;
	my $i = shift;
	
	if ($i eq 'a') {
		return $a;
	} elsif ($i eq 'b') {
		return $b;
	} elsif ($i eq 'c') {
		return $c;
	} elsif ($i eq 'd') {
		return $d;
	} else {
		return $i;
	}
}
