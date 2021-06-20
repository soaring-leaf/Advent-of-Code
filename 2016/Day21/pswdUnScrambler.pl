#!usr/local/bin/perl
use warnings;
use strict;

#my $pswd = 'bfheacgd';
my $pswd = 'fbgdceah';
my @instr;

open(MYFILE,'<input.txt') or die "Can't open input file: $!";

while (<MYFILE>) {
	chomp($_);
	unshift(@instr,$_);
}

close(MYFILE);

foreach my $i (@instr) {
	my @stp = split(' ',$i);
	
	$pswd = processStep($pswd,@stp);
}

print "password is now $pswd \n";

exit 0;
# ======================== End Main Section =================================
sub processStep {
	my $str = shift;
	my @step = @_;
	
	if ($step[0] eq 'reverse') {
		shift(@step); shift(@step);
		$str = rev($str,@step);
	} elsif ($step[0] eq 'rotate') {
		shift(@step);
		
		if ($step[0] eq 'left') {
			$step[0] = 'right';
		} elsif ($step[0] eq 'right') {
			$step[0] = 'left';
		}
		
		if ($step[0] eq 'based') {
			my $e = pop(@step);
			my $num = index($str,$e);
			
			if ($num < 2) {
				$num = 1;
				$step[0] = 'left';
			} elsif ($num == 6) {
				$num = 0;
			} elsif ($num == 7) {
				$num = 4;
				$step[0] = 'left';
			} elsif ($num == 3) {
				$step[0] = 'left';
				$num--;
			} elsif ($num == 4) {
				$num = 1;
			} # if num = 5 or 2 rotating right that many times
			  # no need to do anything
			
			$step[1] = $num;			
		}
		
		$str = rotate($str,@step);		
	} elsif ($step[0] eq 'move') {
		$str = move($str,$step[5],$step[2]);
	} else {
		if ($step[1] eq 'letter') {
			$step[2] = index($str,$step[2]);
			$step[5] = index($str,$step[5]);
		}
		
		if ($step[2] > $step[5]) {
			$str = move($str,$step[2],$step[5]);
			$str = move($str,($step[5]+1),$step[2]);
		} else {
			$str = move($str,$step[5],$step[2]);
			$str = move($str,($step[2]+1),$step[5]);
		}	
	}
	
	return $str;
}

sub move {
	my $s = shift;
	my $strt = shift;
	my $end = shift;
	my @s = split('',$s);
	my $char = splice(@s,$strt,1);
	splice(@s,$end,0,$char);
	
	return join('',@s);	
}

sub rotate {
	my $s = shift;
	my $dir = shift;
	my $num = shift;
	my $s1 = '';	
	my $s2 = '';
	
	#print "num is $num\n";
	$num = $num % length($s); # just in case rotation is multiple times around
	#print "num is now $num\n";
	
	if ($num == 0) {
		return $s;
	}
	
	if ($dir eq 'left') {
		$s1 = substr($s,0,$num);
		$s2 = substr($s,$num);
	} else {
		$s1 = substr($s,0,(length($s)-$num));
		$s2 = substr($s,(0-$num));
	}
	
	#print "segments are $s1 and $s2 and will be sent back in reverse order\n";
	
	return $s2.$s1;
}

#reverse substr from I to K
sub rev {
	my $s = shift;
	my $i = shift;
	my $k = pop;
	my $s1 = substr($s,0,$i);
	my $s2 = '';
	my $sR = substr($s,$i,($k-$i+1));
	
	if (length($s) ne ($k+1)) {
		$s2 = substr($s,($k+1));
	}
	
	$sR = reverse($sR);
	
	return $s1.$sR.$s2;	
}
