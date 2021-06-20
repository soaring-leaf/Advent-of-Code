#!/usr/bin/perl
use warnings;
use strict;

my @check = ('byr','iyr','eyr','hgt','hcl','ecl','pid');
my @currPP = ();
my $data = "";
my $value = "";
my @validPPs = ();
my $count = 0;
my $c = 0;
my $valid = 0;
my $hexCheck = '0123456789abcdef';
my $numCheck = '0123456789';
my @valCheck = ();


#open(INPUT,"<","input.txt") or die "Can't open Input.txt $!";
open(INPUT,"<","test.txt") or die "Cant' open Test.txt $!";

while(<INPUT>) {
	chomp;
	if (length($_) == 0) {
		#process passport
		$c++;
		if(scalar(@currPP) < 7) {
			#Not Valid, do nothing
		} else {
			my %pport; #new hash to process the current passport
			
			foreach (@currPP) { # put the data into a Passport hash
				($data,$value) = split(':',$_);
				$pport{$data} = $value;
				print "$data ";
			}
			print "\n";
			
			if (scalar(@currPP) == 8) { #if all 8 data points are there, it's valid
				$valid++;
			} else {
				$count = 0;
				
				for (my $i=0;$i<7;$i++) {
					if(!exists($pport{$check[$i]})) { #if a value is missing
						$i = 8; #end loop (stop checking)
						$count = -1; #invalidate for check
					} else { #check for valid data
						$value = $pport{$check[$i]};
						if($i == 0 && $value >= 1920 && $value <= 2002) { 
							#BYR check
							$count++;
						} elsif($i == 1 && $value >= 2010 && $value <= 2020) {
							#IYR check
							$count++;
						} elsif($i == 2 && $value >= 2020 && $value <= 2030) {
							#EYR check
							$count++;
						} elsif($i == 3) {
							#HGT check
							if(substr($value,-2) eq 'in') {
								$value = substr($value,0,-2);
								if ($value <= 76 && $value >= 59) {
									$count++;
								} else {
									$i = 8;
									$count = -1;
								}
							} elsif(substr($value,-2) eq 'cm') {
								$value = substr($value,0,-2);
								if ($value <= 193 && $value >= 150) {
									$count++;
								} else {
									$i = 8;
									$count = -1
								}
							} else {
								$i = 8;
								$count = -1;
							}
						} elsif ($i == 4) {
							#HCL check
							if(substr($value,0,1) eq '#') {
								@valCheck = split('',$value);
								for (my $h=0;$h<scalar(@valCheck);$h++) {
									if(index($hexCheck,$valCheck[$h]) == -1) {
										$h = scalar(@valCheck);
										$count = -1;
									}
								}
								if ($count == -1) {
									$i = 8;
								} else {
									$count++;
								}
							} else {
								$i = 8;
								$count = -1;
							}
						} elsif ($i == 5) {
							#ECL Check
							if ($value eq 'amb' || $value eq 'blu' || $value eq 'brn' 
								|| $value eq 'gry' || $value eq 'grn' || $value eq 'hzl'
								|| $value eq 'oth') {
									$count++;
							} else {
								$i = 8;
								$count = -1;
							}
						} elsif ($i == 6 && length($value) == 9) {
							#PID Check
							@valCheck = split('',$value);
							for (my $n=0;$n<9;$n++) {
								if(index($numCheck,$valCheck[$n]) == -1) {
									$n = 9;
									$count = -1;
								}
							}
							if ($count == -1) {
								$i = 8;
							} else {
								$count++;
							}
						} else {
							$i = 8;
							$count = -1;
						} #end value check
					} #end validation check
				} #end for loop for check
				
				if ($count > 0) { #if the count is not invalid, add the passport to the list
					print "this one looks good\n";
					$valid++;
				}
			} # end of else for checking
				
		} # end of else for processing
		
		#end of processing; prep for next passport in batch
		@currPP = ();
	} else {
		#continue reading from batch file
		push(@currPP,split(' '));
	}
}

close(INPUT);

print "Out of $c passports, the number of valid passports found is $valid.\n";

exit(0);
#==========================================================================
