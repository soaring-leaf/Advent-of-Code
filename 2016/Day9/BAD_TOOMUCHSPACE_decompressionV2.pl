#!/usr/local/bin/perl
use warnings;
use strict;

my $again = 1;
my $len = 0;

while ($again) {
	$again = 0; # reset again counter
	
	open(MYFILE,"<input.txt") or die "Couldn't open input file: $!";

	while(<MYFILE>) {
		chomp($_);
		if (length($_) > 0) {
			$again = $again + decompress($_);
		}
	}
	
	close(MYFILE);
	system("del input.txt");
	system("ren out.txt input.txt");
	
	print "repeating, found at least $again instances of markers\n";	
}

open(MYFILE,"<final.txt") or die "Couldn't open final file to count characters: $!";

while(<MYFILE>) {
	chomp($_);
	$len = $len+length($_);
	
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
	
	open(OUTPUT,">>out.txt") or die "Can't open output file: $!";
	open(FINAL,">>final.txt") or die "Can't open final file: $!";
	
	#print "length of string in sub is $k\n";
	
	if (index($f,'(',$i) == -1) {
		print FINAL $f."\n";
		close(OUTPUT);
		close(FINAL);
		return $counter;
	}
	
	while ($i < $k) {
		#$counter++;
		#print "i is $i\n";
		$mark = substr($f,index($f,'(',$i),((index($f,')',$i))-(index($f,'(',$i))));
		
		if (index($f,'(',$i) == -1) {
			$i = $k;
		} else {
			if (index($f,'(',$i) > $i)  {
				$s = $s.substr($f,$i,(index($f,'(',$i)-$i));
				print FINAL substr($f,$i,(index($f,'(',$i)-$i))."\n";
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
		
			for (my $c=0;$c<$repeat;$c++) {
				$s = $s.$mark;
				print OUTPUT $mark;
			}
			print OUTPUT "\n";
		
			$i = $i+length($mark);
			#print "i moved to end of info: $i\n";
		}
	}	
	
	close(OUTPUT);
	close(FINAL);
	#print "number of markers found are $counter\n";
	
	return $counter;
}
