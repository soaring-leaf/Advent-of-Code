#!/usr/local/bin/perl
use warnings;
use strict;

my $len = 0;

open(MYFILE,"<input.txt") or die "Couldn't open file: $!";

while(<MYFILE>) {
	chomp($_);
	
	$len = decompress($_);
}

close(MYFILE);

print "length of file is $len\n";

exit 0;
#====================== End Main Section =============================
sub decompress {
	my $f = shift;
	my $s = '';
	my $num = 0;
	my $repeat = 0;
	my $i = 0;
	my $k = length($f);
	my $mark = '';
	my $counter = 0;
	my $L = 0;
	
	#open(OUTPUT,">>out.txt") or die "Can't open output file: $!";
	#open(FINAL,">>final.txt") or die "Can't open final file: $!";
	
	#print "length of string in sub is $k\n";
	
	# Recursion Base Case if a Marker isn't found, 
	# return the length of the string	
	if (index($f,'(',$i) == -1) {
		return $k;
	}
	
	while ($i < $k) {
		#$counter++;
		#print "i is $i\n";
		$mark = substr($f,index($f,'(',$i),((index($f,')',$i))-(index($f,'(',$i))));
		
		if (index($f,'(',$i) == -1) {
			$i = $k;
		} else {
			if (index($f,'(',$i) > $i)  {
				#print FINAL substr($f,$i,(index($f,'(',$i)-$i))."\n";
				$L = $L+length(substr($f,$i,(index($f,'(',$i)-$i)));
				#$counter = $counter+(index($f,'(',$i)-$i);
			}
			
			$i = (index($f,')',$i)+1);
			#print "moved i to end of marker, I is now $i\n";
			($num, $repeat) = split('x',$mark);
			#$counter = $counter+(substr($num,1)*$repeat);
			$mark = substr($f,$i,substr($num,1));
			
			if (index($mark,'(') >= 0) {
				$counter++;
			}
			
			#print "marker looks like $num, $repeat\n";
			#print "info to repeat looks like $mark\n";
			
			$L = $L + (decompress($mark)*$repeat);
					
			$i = $i+length($mark);
			#print "i moved to end of info: $i\n";
		}
	}	
	
	#close(OUTPUT);
	#close(FINAL);
	#print "number of markers found are $counter\n";
	
	return $L;
}
