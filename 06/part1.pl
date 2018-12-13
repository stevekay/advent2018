#!/bin/perl
open(A,$ARGV[0]);
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

for($y=0;$y<=$ymax;$y++) {
	for($x=0;$x<=$xmax;$x++) {
		$b[$y][$x]=99999;
		$mydist[$y][$x]=99999;
	}
}
for($p=0;$p<$pcount;$p++) {
	$x=$pointx[$p];
	$y=$pointy[$p];
	for($dy=0;$dy<=$ymax;$dy++) {
		for($dx=0;$dx<=$xmax;$dx++) {
			$dist=abs($dx-$x)+abs($dy-$y);

			#print " measuring distance to ($dx,$dy), =",$dist,"\n";
			if($dist == $mydist[$dy][$dx]) {
				$grid[$dy][$dx]='.';
			}
			if($dist < $mydist[$dy][$dx]) {
				#print " closer than what I had already, ",$mydist[$dy][$dx],"\n";
				$mydist[$dy][$dx]=$dist;
				$grid[$dy][$dx]=$letter[$p];
			}
		}
	}
	
}

# determine edge letters
for($y=0;$y<=$ymax;$y++) {
	for($x=0;$x<=$xmax;$x++) {
		if($y==0 || $y==$ymax || $x==0 || $x==$xmax) {
			$letter=lc($grid[$y][$x]);
			$edge{$letter}=1;
		}
	}
}


# look through the grid for any letters that are not in edge
for($y=0;$y<=$ymax;$y++) {
	for($x=0;$x<=$xmax;$x++) {
		$letter=$grid[$y][$x];
		next if(exists($edge{$letter}));
		$total{$letter}++;
	}
}

print $total{ (sort { $total{$a} <=> $total{$b} } keys %total)[-1] },"\n";
