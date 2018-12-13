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

zcreate(1,0);

sub zcreate {
 my($id,$counter)=@_;
 $children=$b[$counter];
 $meta=$b[$counter+1];
 printf "create: creating node %c, from counter %d, %d child nodes and %d metadata entries\n",$id+64,$counter,$children,$meta;
 $counter+=2;
 if($counter >= $#b) {
 # print "done\n";
  exit;
 }
 printf "            - %c, which has %d child nodes (TBA) and %d metadata entries (TBA)\n",$id+64,$children,$meta;
 $myid++;
 if($children) {
	zcreate($myid,$counter) 
 }
 print "adding meta $meta to counter $counter, result is ",$counter+$meta,"\n";
 $counter+=$meta;
 if($counter >= $#b) {
  exit;
 }
 zcreate($myid,$counter);
 print "foo\n";
 print "x\n";
}
