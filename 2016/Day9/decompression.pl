#!/usr/local/bin/perl
use warnings;
use strict;

my $str = '';
my $len = 0;

open(MYFILE,"<input.txt") or die "Couldn't open file: $!";

while(<MYFILE>) {
	chomp($_);
	
	$str = decompress($_);
	$len = length($str);
	
}

close(MYFILE);

print "length of file is $len\n";

exit 0;
#====================== End Main Section =============================
sub decompress {
	my $f = shift;
	my $s = '';
	#my @a = split('',$f);
	my $num = 0;
	my $repeat = 0;
	my $i = 0;
	my $k = length($f);
	my $mark = '';
	my $counter = 0;
	
	open(OUTPUT,">out.txt") or die "Can't open output file: $!";
	
	print "length of string in sub is $k\n";
	
	while ($i < $k) {
		#$counter++;
		print "i is $i\n";
		$mark = substr($f,index($f,'(',$i),((index($f,')',$i))-(index($f,'(',$i))));
		
		if (index($f,'(',$i) == -1) {
			$i = $k;
		} else {
			if (index($f,'(',$i) > $i)  {
				$s = $s.substr($f,$i,(index($f,'(',$i)-$i));
				print OUTPUT substr($f,$i,(index($f,'(',$i)-$i))."\n";
				$counter = $counter+(index($f,'(',$i)-$i);
			}
			
			$i = (index($f,')',$i)+1);
			#$i = $i+length($mark)+1;
			print "moved i to end of marker, I is now $i\n";
			($num, $repeat) = split('x',$mark);
			$counter = $counter+(substr($num,1)*$repeat);
			$mark = substr($f,$i,substr($num,1));
			print "marker looks like $num, $repeat\n";
			print "info to repeat looks like $mark\n";
		
			for (my $c=0;$c<$repeat;$c++) {
				$s = $s.$mark;
				print OUTPUT $mark;
			}
			print OUTPUT "\n";
		
			$i = $i+length($mark);
			print "i moved to end of info: $i\n";
		}
	}	
	
	close(OUTPUT);
	print "number of markers found are $counter\n";
	
	return $s;
}
