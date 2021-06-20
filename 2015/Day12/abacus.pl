#!/usr/local/bin/perl
use warnings;
use strict;
use Scalar::Util qw(looks_like_number);

my @line;
my $input = '';
my $count = 0;

#open (MYFILE,"<input.txt") or die "unable to open file: $!";
open (MYFILE,"<test.txt") or die "unable to open file: $!";

while (<MYFILE>) {
	chomp($_);
	$input = join('',$input,$_);
}

@line = processForRed($input);
	
$count = processLine(@line) + $count;

print "sum of numbers is $count";

exit(0);
#====================== End Main Section =============================
sub processForRed {
	my $file = $_[0];
	my @arr = split('',$file);
	my $index = 0;
	my $objStart = 0;
	my $objEnd = 0;
	my $found = 0;
	my $numA = 0;
	my $numO = 0;
	
	$index = index($file,'red',$index);
	
	print "index is $index at start; file is \n$file \n";

	
	while (!($index == -1)) {
	
		while (!($found)) {
			$index++;
			if ($arr[$index] eq '[') {
				$numA++;
			} elsif ($arr[$index] eq '{') {
				$numO++;
			} elsif (($arr[$index] eq ']') && ($numA > 0)) {
				$numA--;
			} elsif (($arr[$index] eq '}') && ($numO > 0)) {
				$numO--;
			} elsif ($arr[$index] eq ']') {
				#this is an array, found end, do nothing
				$found = 1;
			} elsif ($arr[$index] eq '}') {
				#this is obj, need to remove
				$found = 1;
				$objEnd = $index;
				$objStart = findStart($index,\@arr);
				$index = $objStart;
				#print "start $objStart, end $objEnd \n";
				splice(@arr,$objStart,($objEnd-$objStart)+1);
				substr($file,$objStart,($objEnd-$objStart)+1,'');
			}
			print "index is $index; length of file is ". scalar(@arr) . "\n";
		} #end while loop for obj discovery and removal
		
		$found = 0;
		$index = index($file,'red',$index);
		print "index is $index at end of loop;file is \n$file\n";
		
	} #end search for red while loop
	
	return (@arr);
}

sub findStart {
	my $i = $_[0];
	my $a = $_[1];
	my $f = 0;
	my $n = 0;
	
	while (!($f)) {
		$i--;
		if ($a->[$i] eq '}') {
			$n++;
		} elsif (($a->[$i] eq '{') && ($n > 0)) {
			$n--;
		} elsif ($a->[$i] eq '{') {
			#this is obj, need to remove
			$f = 1;
		}
	} #end while loop for obj start
	
	return $i;
}

sub processLine {
	my @a = @_;
	my $c = 0;
	my $num = '';
	my $curr;
	my $haveNum = 0;
	#print "array is \n";
	while (scalar(@a) > 0) {
		$curr = shift(@a);
		#print "$curr";
		
		if ($curr eq '-') {
			$num = '-';
			$haveNum = 1;
		} elsif (looks_like_number($curr)) {
			$num = join("",$num,$curr);
			$haveNum = 1;
		} elsif ( ($haveNum == 1) && !(looks_like_number($curr)) ) {
			$c = $c + $num;
			$num = '';
			$haveNum = 0;
		}
		
		
	}
	
	return ($c);
}
