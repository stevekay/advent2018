#!/usr/bin/perl
$s=$ARGV[0];

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

for($x=0;$x<300-3;$x++) {
	if($x%25==0) { print scalar localtime," x=$x of 300\n" }
	for($y=0;$y<300-3;$y++) {
		$tot=0;
		for($xd=0;$xd<3;$xd++) {
			for($yd=0;$yd<3;$yd++) {
				$tot+=mycalc($x+$xd,$y+$yd,$s);
			}
		}
		$gridtot[$x][$y]=$tot;
	}
}
$highest=-1;
for($x=0;$x<300-3;$x++) {
	for($y=0;$y<300-3;$y++) {
		if($gridtot[$x][$y] > $highest) {
			$highest=$gridtot[$x][$y];
			$highx=$x;
			$highy=$y;
		}
	}
}

print "serial $s, ($highx,$highy) with $highest\n";
