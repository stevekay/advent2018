#!/bin/perl
#
# dabAcCaCBAcCcaDA  The first 'cC' is removed.
# dabAaCBAcCcaDA    This creates 'Aa', which is removed.
# dabCBAcCcaDA      Either 'cC' or 'Cc' are removed (the result is the same).
# dabCBAcaDA        No further actions can be taken.
#

# TODO : This is very slow to run !

open(A,$ARGV[0]) || die "unable to open $ARGV[0] : $!";
$x=<A>;
for $l ( 'a' .. 'd' ) {
 print scalar localtime," processing char $l\n";
 $_=$x;
 #print " pre-removal, was  $_";
 s/$l//gi;
 $a=$_;
 #print " post-removal, now $a";
 $exploded=0;
 while($exploded==0) {
  #if(length($a) % 101 == 0) { print scalar localtime," length=",length($a),"\n" }
  #print "loop, length is now ",length($a),"\n";
  for($c=0;$c<length($a)-2 && $exploded==0;$c++) {
   $first=substr($a,$c,1);
   $second=substr($a,$c+1,1);
   #printf "Char #%02d value %s, comparing %s and %s\n",$c,substr($a,$c,1),$first,$second;
   next if $first eq $second; # both same, same case
   if($first eq lc($second) || $first eq uc($second)) {
    #print "got it\n";
    #print "was $a";
    $a=substr($a,0,$c) . substr($a,$c+2,length($a)-$c+1);
    #print "now $a";
    $exploded=1;
   }
  }
  if($exploded==0) {
   print " -> answer is ",length($a)-1,"\n";
   $exploded=1;
  } else {
   $exploded=0;
  }
 }
}
