#!/usr/local/bin/perl
use warnings;
use strict;
use Data::Dumper;

my $message = '';
my @msg;
my @chars;

open (MYFILE,"<input.txt") or die "couldn't open file, $!";

while (<MYFILE>) {
	chomp($_);
	@msg = split('',$_);
	insertMsg(\@chars,@msg);

} # end while loop

close MYFILE;

#print Dumper(\@chars);
$message = processMsg(@chars);

print "message is $message\n";

exit 0;
#====================== End Main Section =============================
sub insertMsg {
	my $a = shift;
	my @m = @_;
	
	push(@{$a},\@m);
}

sub processMsg {
	my @m = @_;
	#print Dumper(\@m);
	my %count;
	my $len = scalar(@m);
	my $msg = '';
	
	for (my $i=0;$i<8;$i++) { 
		for (my $k=0;$k<$len;$k++) {
			#print "value at $k $i is ".$m[$k][$i]."\n";
			if ($count{$m[$k][$i]}) {
				$count{$m[$k][$i]}++;
			} else {
				$count{$m[$k][$i]} = 1;
			}
		} # end nested for loop
		
		#$msg = $msg.getMostCommon(\%count);
		$msg = $msg.getLeastCommon(\%count);
		%count = ();
		
	} # end outer for loop
	return $msg;
}

sub getLeastCommon {
	my $h = shift;
	my $min = -1;
	my $char = '';
	my @elem = keys %$h;
	
	$char = $elem[0];
	$min = $h->{$char};
	shift(@elem);
	
	foreach my $e (@elem) {
		if ($h->{$e} < $min) {
			$min = $h->{$e};
			$char = $e;
		}
	}

	return $char;	
}

sub getMostCommon {
	my $h = shift;
	my $max = 0;
	my $char = '';
	my @elem = keys %$h;
	
	foreach my $e (@elem) {
		if ($h->{$e} > $max) {
			$max = $h->{$e};
			$char = $e;
		}
	}
	#print "character should be $char \n";
	return $char;	
}
