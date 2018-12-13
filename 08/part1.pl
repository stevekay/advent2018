#!/bin/perl
open(A,$ARGV[0]);
$a=<A>;
chomp $a;
@b=split(/ +/,$a);
for $c (0 .. $#b) {
 print "c=$c val=",$b[$c],"\n";
}
$myid=1;

$y=create($myid,0);
print "done, pos=$y\n";

sub create {
 my($id,$pos)=@_;

 $children=$b[$pos];
 $meta=$b[$pos+1];
 print " -> id=$id pos=$pos children=$children meta=$meta\n";
 $node{$id}=1;
 $node{$id}{childcount}=$children;
 $id++;
 if($children>0) {
  create($id,$pos+2)
 } else {
  create($id,$pos+2+$meta);
 }
}

