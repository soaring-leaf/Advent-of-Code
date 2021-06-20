#!/usr/local/bin/perl
use warnings;
use strict;

my $len = 0;
my $line = 0;
my $codeCount = 0;
my $charCount = 0;
my $totCount = 0;
my @str;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";
#open (MYFILE,"<test.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	$line = trim($_);
	
	$len = length($line);
	$codeCount = $codeCount + $len;
	
	#print "line at start is $line ; \n";

	# Part 1	
#	if (index($line,'\\') > -1) {
#		$line = remEscChars($line);
#	}

	# Part 2
	$line = escChars($line);
	
	#add quotes back on
	@str = split('',$line);
	push(@str,('"'));
	unshift (@str,('"'));
	$line = join('',@str);
	
	$len = length($line);

	$charCount = $charCount + $len;

	#print "line is $line; String length now equals $len. \n";

} # end while loop

close MYFILE;

$totCount = $charCount - $codeCount;

print "There are a total of $codeCount code characters in the list. \n";
print "There are a total of $charCount characters in the list. \n";
print "There are a total of $totCount total in the list. \n";

exit 0;
#====================== End Main Section =============================
sub escChars {
	my $word = $_;
	my $escPos = 0;
	my $quotPos = 0;
	my $offset = 0;
	my $escStr = 0;
	my @wrd;

	$word = trim($word);
	
	$escPos = index($word,'\\');
	$quotPos = index($word,'"');
	
	while ($escPos ne '-1') {
		#just add the '\'
		@wrd = split('',$word);
		splice(@wrd,$escPos,0,('\\'));
		$escPos = $escPos + 2;
		
		$word = join('',@wrd);
		
		#check for another instance of esc chars
		$escPos = index($word,'\\',$escPos);		
	}
	
	while ($quotPos ne '-1') {
		#just add the '\'
		@wrd = split('',$word);
		splice(@wrd,$quotPos,0,('\\'));
		$quotPos = $quotPos + 2;
		
		$word = join('',@wrd);
		
		$quotPos = index($word,'"',$quotPos);
	}

	return $word;
}

sub remEscChars {
	my $word = $_;
	my $escPos = 0;
	my $offset = 0;
	my $escStr = 0;
	my @wrd;

	$word = trim($word);
	
	$escPos = index($word,'\\');
	
	while ($escPos ne '-1') {
		$offset = $escPos + 1;
		
		#remove the esc char
		$escStr = substr($word,$offset,1);
		
		if ($escStr ne 'x') {
			#just remove the '\'
			@wrd = split('',$word);
			splice(@wrd,$escPos,1);
		} else {
			#change hex to char
			@wrd = split('',$word);
			splice(@wrd,$escPos,4,('B'));
			#$offset = $offset - 3;
		}
		
		$word = join('',@wrd);
		
		#check for another instance of esc char
		$escPos = index($word,'\\',$offset);		
	}
	
	return $word;
}

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
