#!/usr/local/bin/perl
use warnings;
use strict;
use Scalar::Util qw(looks_like_number);

my %connections;
my $answer = 'a';
my @inPieces;
my $key;
my $value;
my @hList;
my $len = 0;
my $signal = 0;

open (MYFILE,"<input.txt") or die "Couldn't open file, $!";
#open (MYFILE,"<test.txt") or die "Couldn't open file, $!";

while (<MYFILE>) {
	@inPieces = split('->', $_);
	$key = trim(pop(@inPieces));
	$value = trim(pop(@inPieces));
	$connections{$key} = $value;
} # end while loop

close MYFILE;

#@hList = keys %connections;
#$len = scalar(@hList);

print "hash $answer should be " . $connections{$answer} . "\n";
$signal = solvePath($answer,\%connections);
	
print "a carries signal $signal; applying signal to wire 'b': \n";

# resetting wires and overriding wire B
open (MYFILE,"<input.txt") or die "Couldn't open file, $!";

%connections = ();

while (<MYFILE>) {
	@inPieces = split('->', $_);
	$key = trim(pop(@inPieces));
	$value = trim(pop(@inPieces));
	$connections{$key} = $value;
} # end while loop

close MYFILE;

$connections{'b'} = $signal;

$signal = solvePath($answer,\%connections);

print "wire a now carries $signal\n";

exit 0;
#====================== End Main Section =============================
sub solvePath {
	my $oper;
	my ($k, $hRef) = @_;
	my $val = $hRef->{$k};
	my @items = split(' ',$val);
	my $sLen = scalar(@items);
	my $w1;
	my $w2;
	my $sig1;
	my $sig2;
	
	#print "key is: $k; val: $val; \n";
	#print "length of current circuit is $sLen\n";
	
	#if $val is a number, that is the base case, return $val
	if ($sLen == 1) {
		if (looks_like_number($val)) {
			return ($val);
		} else {
			$sig1 = solvePath($val,$hRef);
			return ($sig1);
		}
	}
	
	if ($sLen == 2) {
		$w1 = $items[1];
		#print "len is 2, items: w1: $w1 \n";
		$sig1 = solvePath($w1,$hRef);
		#print "sig1: $sig1; not sig1: " . negSig($sig1) . "\n";
		$sig1 = negSig($sig1);
		return $sig1;
	} elsif ($sLen == 3) {
		$w1 = $items[0];
		$oper = $items[1];
		$w2 = $items[2];
		#print "len is 3, items: w1:$w1, w2:$w2, oper:$oper \n";
		
		if ( !(looks_like_number($w1)) ) {
			$sig1 = solvePath($w1,$hRef);
			#$sig1 = sigToBIN($sig1);
		} else {
			$sig1 = $w1;
		}
		
		if ( !(looks_like_number($w2)) ) {
			$sig2 = solvePath($w2,$hRef);
			#$sig2 = sigToBIN($sig2);
		} else {
			$sig2 = $w2;
		}
		
	} else {
		die "error in input, expecting max 2 wires; value is $val.\n";
	}
	
	#print "solving $sig1, $oper, $sig2 and answer is ";
	$hRef->{$k} = getSignal($sig1,$oper,$sig2);
	#print $hRef->{$k} . "\n"; 
	return ( $hRef->{$k} );
}

sub negSig {
	my $s = sigToBIN($_[0]);
	my @sArr = split('',$s);
	
	for (my $i=0; $i<scalar(@sArr); $i++) {
		if ($sArr[$i] eq '0') {
			$sArr[$i] = 1;
		} else {
			$sArr[$i] = 0;
		}
	} #end for loop
	
	$s = join('',@sArr);
	$s = bin2dec($s);
	
	return $s;
}

sub sigToDEC {
	my $s = $_[0];
	return (sprintf('%u',$s));
}
sub dec2bin {
    my $str = unpack("B32", pack("N", shift));
    $str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
    return $str;
}

sub bin2dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

sub sigToBIN {
	my $s = $_[0];
	return (sprintf('%016b',$s));	
}

sub getSignal {
	my ($a, $op, $b) = @_;
	my $s = 0;
	#print "a is $a \n";
	#print "b is $b \n";
	
	$a = trim($a);
	$b = trim($b);

	if ($op eq 'AND') {
		$a = dec2bin($a);
		$b = dec2bin($b);
		($a,$b) = padOps($a,$b);
		$s = ($a & $b);
		$s = bin2dec($s);
		return $s;
	} elsif ($op eq 'OR') {
		#print "IN OR \n";
		$a = dec2bin($a);
		$b = dec2bin($b);
		($a,$b) = padOps($a,$b);
		$s = ($a | $b);
		$s = bin2dec($s);
		return $s;
	} elsif ($op eq 'LSHIFT') {
		#print "a is $a and b is $b\n";
		#print "IN LSHIFT \n";
		return ($a << $b);
	} elsif ($op eq 'RSHIFT') {
		#print "IN RSHIFT \n";
		return ($a >> $b);
	} else {
		die "error in input, expecting valid operator; value is $op.\n";
	}
}

sub padOps {
	my ($a,$b) = @_;
	
	while (length($a) != length($b)) {
		if (length($a) < length($b)) {
			$a = '0'.$a;
		} else {
			$b = '0'.$b;
		}
	}
	
	return ($a,$b);
}

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
