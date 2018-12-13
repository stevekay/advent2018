#!/bin/perl
open(A,$ARGV[0])||die;
while(<A>) {
	chomp;
	($x,$y)=split(/, /);
	if($x > $xmax) { $xmax=$x }
	if($y > $ymax) { $ymax=$y }
	$pointx[$pcount]=$x;
	$pointy[$pcount]=$y;
	$letter[$pcount]=++$label;
	$grid[$y][$x]=$label;
	$pcount++;
}
$xmax++;

# for each location, calc distance to each letter
for($y=0;$y<=$ymax;$y++) {
	for($x=0;$x<=$xmax;$x++) {
		$tot=0;
		for($p=0;$p<$pcount;$p++) {
			$dist=abs($x-$pointx[$p])+abs($y-$pointy[$p]);
			$tot+=$dist;
		}
		if($tot<10000) { $count++ }
	}
}
print $count,"\n";
