#!/usr/bin/perl  -w
use strict;
my($x,$y,$seconds,$minx,$miny,$maxx,$maxy,$xspeed,$yspeed);
my @positions;

open(A,$ARGV[0])||die;
while(<A>) {
	next unless /^position=< *(-*[0-9]+), *(-*[0-9]+)> velocity=< *(-*[0-9]+), *(-*[0-9]+)>/;
	push @positions,[ $1, $2, $3, $4 ];
}
close A;

do { 
	$seconds++;
	$maxy=-5000000;
	$miny=5000000;
	$maxx=-5000000;
	$minx=5000000;
	for (0 .. $#positions) {
		($x,$y,$xspeed,$yspeed)=@{$positions[$_]};
		$x+=$xspeed;
		$y+=$yspeed;
 		$positions[$_]=[ $x, $y, $xspeed, $yspeed ];
		if($y>$maxy) { $maxy=$y}
		if($y<$miny) { $miny=$y}
		if($x<$minx) { $minx=$x}
		if($x>$maxx) { $maxx=$x}
	}
} until ($maxy-$miny < 10);

my @v;
for($x=$minx;$x<=$maxx;$x++) {
	for($y=$miny;$y<=$maxy;$y++) {
		$v[$x+abs($minx)][$y+abs($miny)]='.';
	}
}
for(@positions) {
	($x,$y,$xspeed,$yspeed)=@{$_};
	$v[$x+abs($minx)][$y+abs($miny)]='#';
}
for($y=$miny;$y<=$maxy;$y++) {
	for($x=$minx;$x<=$maxx;$x++) {
		print $v[$x+abs($minx)][$y+abs($miny)];	
	}
	print "\n";
}
print "seconds=$seconds\n";
