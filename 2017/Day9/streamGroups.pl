#!/usr/local/bin/perl
use warnings;
use strict;

my $stream = '';
my $score = 0;

open(MYFILE,"<input.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	$stream = $_;
}

close MYFILE;

$stream = remGarbage($stream);

#open(MYFILE,">out.txt") or die "Can't write to file $!";
#print MYFILE $stream;
#close(MYFILE);

$score = groupScore($stream);

print "Total score for this stream is $score\n";

exit 0;
#====================== End Main Section =============================

# Finds and removes garbage from the stream
sub remGarbage {
	my $s = $_[0];
	my $gStrt = -1;
	my $gEnd = -1;
	my $c = '';
	my $gbg = '';
	my $gChars = 0;
	
	for(my $i=0;$i<length($s);$i++) {
		$c = substr($s,$i,1); # Get the next character to check
		if($c eq '!') {
			$i++;
		} else { # Finding Garbage
			if($gStrt == -1 && $c eq '<') { # Found start of Garbage
				$gStrt = $i;
			} elsif ($c eq '>') { # Found End of Garbage
				$gEnd = $i;
				# Found end; Remove it!
				#$gbg = substr($s,$gStrt,($gEnd-$gStrt+1));
				$gbg = substr($s,$gStrt,($gEnd-$gStrt+1),'');
				$gChars = $gChars + countChars($gbg);
				$i = $gStrt;
				$gStrt = -1;
				$gEnd = -1;
			}
		} # end of Finding Garbage If
	} # end For loop
	
	print "There are $gChars non-canceled chars in the garbage\n";
	
	return($s);
} # End removing garbage

# counts characters in the garbage that are being removed
# does not count the < or > and also doesn't count cancelled chars
sub countChars {
	my $g = $_[0];
	my $num = 0;
	my $c = '';
	
	#print "garbage being counted is $g\n";
	
	for(my $i=1;$i<length($g)-1;$i++) {
		$c = substr($g,$i,1);
		if($c eq '!') {
			$i++;
		} else {
			$num++;
		}
	} # end for loop

	return($num);
}

# calculate the total score for stream
sub groupScore {
	my $s = $_[0];
	my $val = 0;
	my $scr = 0;
	my $c = '';
	
	for(my $i=0;$i<length($s);$i++) {
		$c = substr($s,$i,1);
		
		if($c eq '{') {
			$val++;
		} elsif($c eq '}') {
			$scr = $scr + $val;
			$val--;
		}
		
	} # end for loop to calc score
	
	return($scr);
}
