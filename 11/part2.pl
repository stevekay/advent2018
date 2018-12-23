#!/usr/bin/perl
$s=$ARGV[0];

sub max ($$) { $_[$_[0] < $_[1]] }

sub mycalc {
	my($x,$y,$serial)=@_;

	$rackid = $x + 10;
	$power = $rackid * $y;
	$power += $serial;
	$power *= $rackid;
	$a = sprintf("%09d",$power);
	$b = substr($a,length($3)-3,1);
	$answer = $b - 5;
 	return $answer;
}

$max=300;
#$max=48;
#$max=4;
for($x=1;$x<=$max;$x++) {
	$gridval[$x]=[ (0) x $max+1 ];
	for($y=1;$y<=$max;$y++) {
		$gridval[$x][$y]=mycalc($x,$y,$s);
	}
}

# init
for($x=1;$x<=$max;$x++) {
	for($y=1;$y<=$max;$y++) {
		$xtot[$x][$y]=[ (0) x $max-$y ];
	}
}

for($y=1;$y<=$max;$y++) {
	for($x=1;$x<=$max;$x++) {
		$v=0;
		for($xd=$x;$xd<=$max;$xd++) {
			$xtot[$x][$y][$xd]+=$gridval[$xd][$y]+$v;
			$v=$xtot[$x][$y][$xd];
			
		}
		
	}
}

# search for highest grid
$highest=-1;
for($x=1;$x<=$max;$x++) {
	for($y=1;$y<=$max;$y++) {
		for($size=1;$size<=$max-max($x,$y)+1;$size++) {
			$tot=0;
			for $a ( 0 .. $size-1 ) {
				$tot+=$xtot[$x][$y+$a][$x+$size-1];
			}
			if($tot > $highest) {
				$highest=$tot;
				$highestx=$x;
				$highesty=$y;
				$highestsize=$size;
			}

		}
	}
}

print "highest was $highest with x $highestx y $highesty size $highestsize\n";
