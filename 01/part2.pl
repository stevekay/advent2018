#!/bin/perl
$a{0}=1;
while(1) {
	open(A,$ARGV[0]) || die;
	while(<A>) {
		chomp;
		$x += $_;
		if(exists($a{$x})) { die $x }
		$a{$x}=1;
	}
	close A;
}
