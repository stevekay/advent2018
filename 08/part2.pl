#!/usr/bin/perl
open(A,$ARGV[0])||die;
@z=split(/ /,<A>);

sub create {
 ($letter,$pos,$parent)=@_;
 local($kidcount,$metacount,$parent);
 $kidcount=$z[$pos++]; 
 $metacount=$z[$pos++];
 $parent=$letter++;
 $nodeval{$parent}=0;
 for ( 1 .. $kidcount ) {
  push @{$tree{$parent}},$letter;
  create($letter++,$pos,$parent);
 }
 while($metacount--) {
  push @{$meta{$parent}},$z[$pos];
  if($kidcount) { 
   $blah=$z[$pos];
   $foo=$tree{$parent}[$blah-1];
   $nodeval{$parent}+=$nodeval{$foo};
  } else {
   $nodeval{$parent}+=$z[$pos];
  }
  $metatotal+=$z[$pos++];
 }
}

create('A',0,"");
print "part1 answer = $metatotal\n";
print "part2 answer = ",$nodeval{A},"\n";
