#!/usr/bin/perl
my($players,$marbles)=@ARGV;
while($freshmarble++<$marbles) {
	if($freshmarble % 23) {
		$oneup=$marblenext{$position};
		$twoup=$marblenext{$oneup};
		$marblenext{$oneup}=$freshmarble;
		if($marbleprev{$oneup} == $oneup) {
			$marbleprev{$oneup} = $freshmarble;
		}
		$marbleprev{$freshmarble}=$oneup;
		$marblenext{$freshmarble}=$twoup;
		$marbleprev{$twoup}=$freshmarble;
		$position=$marblenext{$oneup};
	} else {
		$score{$player}+=$freshmarble;
		$onedown=$marbleprev{$position};
		$twodown=$marbleprev{$onedown};
		$threedown=$marbleprev{$twodown};
		$fourdown=$marbleprev{$threedown};
		$fivedown=$marbleprev{$fourdown};
		$sixdown=$marbleprev{$fivedown};
		$sevendown=$marbleprev{$sixdown};
		$score{$player}+=$sevendown;
		$eightdown=$marbleprev{$sevendown};
		$marblenext{$eightdown}=$sixdown;
		$marbleprev{$sixdown}=$eightdown;
		$position=$marblenext{$sixdown};
		$position=$sixdown;
		$oneup=$marblenext{$sixdown};
		$twoup=$marblenext{$oneup};
	}
	if($player++ == $players) { $player=1 }
}
print $score{ (sort { $score{$a} <=> $score{$b} } keys %score)[-1] },"\n";
