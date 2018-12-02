#!/bin/perl
open(A,$ARGV[0]) || die;
@a=<A>;
for $a (@a) {
	chomp $a;
	for $b (@a) {
		chomp $b;
		$correct=0;
		for $c (0 .. length($a)-1) {
			if(substr($a,$c,1) eq substr($b,$c,1)) {
				$correct++;
			}
		}
		if($correct == length($a)-1) {
			for $d (0 .. length($a)-1) {
				if(substr($a,$d,1) eq substr($b,$d,1)) {
					print substr($a,$d,1);
				}
			}
			print "\n";
			exit;
		}
	}
}
