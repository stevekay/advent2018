#!/bin/perl
open(A,$ARGV[0]);
$a=<A>;
chomp $a;
@b=split(/ +/,$a);
for $c (0 .. $#b) {
 print "c=$c val=",$b[$c],"\n";
}
$myid=1;

# print header
printf "%c\n",$myid+64;
for(@b) {
 printf "%02d ",$_;
}
print "\n";

$level=0;
zcreate(1,0,0);

sub zcreate {
 my($id,$counter,$l)=@_;
 $children=$b[$counter];
 $meta=$b[$counter+1];
 printf "create: creating node %c, l=%d, from counter %d (of %d), %d child nodes and %d metadata entries at level %d\n",$id+64,$l,$counter,$#b,$children,$meta,$level;
 $counter+=2;
 if($counter >= $#b) {
 # print "done\n";
  exit;
 }
 printf "            - %c, which has %d child nodes (TBA) and %d metadata entries (TBA)\n",$id+64,$children,$meta;
 $myid++;
 if($children) {
	print "children=$children\n";
	$l++;
	for $p (1 .. $children) {
		print "doing child # $p of ",$children,"\n";
		zcreate($myid,$counter,$l);
	}
	return;

	#zcreate($myid,$counter) ;
	#return;
 }
 die "l $l id $id\n" if $l==0 && $id != 1;
 #$l--;
 print "done creating children, myid=$myid\n";
 print "level $level / adding meta $meta to counter $counter, result is ",$counter+$meta,"\n";
 $counter+=$meta;
 if($counter >= $#b) {
  exit;
 }
 print "zzzzzzzzzz\n";
 die "l $l id $id\n" if $l==0 && $id != 1;
$l--;
 die "l $l id $id\n" if $l==0 && $id != 1;
 zcreate($myid,$counter,$l);
 return;
 print "foo\n";
 print "x\n";
}
