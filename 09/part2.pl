#!/usr/bin/perl
my($players,$marbles)=@ARGV;

sub walklist {
 my($cur)=@_;
# print "** WALK START, position = $cur\n";

 print "[",$player ? $player : '-',"] ";
 $pos=0;
 $flag=0;
 while($flag==0) {
  unless(exists($marble{$pos})) { die }
#  print $cur==$pos ? "(" : " ",$pos,$cur==$pos ? ")" : " ";
  if($pos == $marblenext{$pos} && $pos) {
	print "at pos $pos, next marble is also $pos\n";
	die;
 }
  $pos=$marblenext{$pos};
  if($pos==0) { $flag=1 }
 }
 print "\n";

}
sub dumplist {
	print "*** DUMP START, cycle $z-------\n";
	for (sort keys %marble) {
		print " key $_ next=",$marblenext{$_}," prev=",$marbleprev{$_},"\n";
	}
	print "*** DUMP END\n";
}

# create first marble

$marblenum=0;
$marble{$marblenum}=1;
$marblenext{$marblenum}=$marblenum;
$marbleprev{$marblenum}=$marblenum;
$position=0;
$player=0;
$freshmarble=0;

while($z++<$marbles) {
	if($z % 100000 == 0) { print scalar localtime," marble $z (",int(($z/$marbles)*100),"%)\n" }
#while($z++<300) {

	# walk the list
#        walklist($position);

	# Increment next available marble number
	$freshmarble++;

	if($freshmarble % 23) {
		# Insert new marble between m+1 and m+2
		$oneup=$marblenext{$position};
		$twoup=$marblenext{$oneup};
		#print "inserting $freshmarble between $oneup and $twoup\n";
		$marble{$freshmarble}=1;
		$marblenext{$oneup}=$freshmarble;
		if($marbleprev{$oneup} == $oneup) {
			$marbleprev{$oneup} = $freshmarble;
		}
		$marbleprev{$freshmarble}=$oneup;
		$marblenext{$freshmarble}=$twoup;
		$marbleprev{$twoup}=$freshmarble;
		#$position++;
		$position=$marblenext{$oneup};
	} else {
		# The current marble value is added to current players score
		$score{$player}+=$freshmarble;
#		print "added $freshmarble to player $player score\n";
		
#		print "removing marble $freshmarble from play\n";
		# Remove marble between m-7 and m-8
		$onedown=$marbleprev{$position};
		$twodown=$marbleprev{$onedown};
		$threedown=$marbleprev{$twodown};
		$fourdown=$marbleprev{$threedown};
		$fivedown=$marbleprev{$fourdown};
		$sixdown=$marbleprev{$fivedown};
		$sevendown=$marbleprev{$sixdown};
#		print "7 down is $sevendown, which will now be added to $player score and removed from play\n";

		$score{$player}+=$sevendown;
		

		# remove $sevendown from play
		$eightdown=$marbleprev{$sevendown};
#		print "8 down is $eightdown, which has next pointing at ",$marblenext{$eightdown},"\n";

		$marblenext{$eightdown}=$sixdown;

#		print " ... now revised to be ",$marblenext{$eightdown},"\n";

#		print "6 down is $sixdown, which has prev pointing at ",$marbleprev{$sixdown},"\n";
		$marbleprev{$sixdown}=$eightdown;
#		print " ... now revised to be ",$marbleprev{$sixdown},"\n";
		# also works
		# for(1..6) {
		#	$position=$marbleprev{$position};
		#}
		#print " aka ",$marbleprev{$position},"\n";

#		print "player $player score = ",$score{$player},"\n";

#		print "position is currently $position\n";
		$position=$marblenext{$sixdown};
		$position=$sixdown;

#		print "manually checking n+1 and n+2\n";
		$oneup=$marblenext{$sixdown};
#		print "  1up = $oneup\n";
		$twoup=$marblenext{$oneup};
#		print "  2up = $twoup\n";
#		print "freshmarble now at $freshmarble\n";
		delete $marblenext{$sevendown};
		delete $marbleprev{$sevendown};
		delete $marble{$sevendown};
#			
#		walklist($position);
	}


	# Go to next player
	if($player++ == $players) { $player=1 }
}

#foreach (sort keys %score) {
# printf "%08d %10d\n",$_+1,$score{$_};
#}
print $score{ (sort { $score{$a} <=> $score{$b} } keys %score)[-1] },"\n";
