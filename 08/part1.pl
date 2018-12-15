#!/usr/bin/perl
open(A,$ARGV[0])||die;
@z=split(/ /,<A>);

sub create {
 ($letter,$pos,$parent)=@_;
 local($kidcount,$metacount);
 $kidcount=$z[$pos++]; 
 $metacount=$z[$pos++];
 $parent=$letter++;
 for $i ( 1 .. $kidcount ) {
  create($letter++,$pos,$parent);
 }
 while($metacount--) {
  $metatotal+=$z[$pos++];
 }
}

create('A',0,"");
print "answer = $metatotal\n";
