#!/bin/perl
open(A,$ARGV[0])||die "unable to open $ARGV[0] : $!";
$verbose=$ARGV[1] eq '-v' ? 1 : 0;
while(<A>) {
 next unless /^#(\d+) +@ +(\d+),(\d+): +(\d+)x(\d+)/;
 $claim=$1;
 $xpos=$2;
 $ypos=$3;
 $width=$4;
 $height=$5;
 for($y=$ypos;$y<$ypos+$height;$y++) {
  for($x=$xpos;$x<$xpos+$width;$x++) {
   if($grid[$y][$x]) {
    $grid[$y][$x]='X';
   } else {
    $grid[$y][$x]=$claim;
   }
  }
 }
}
close A;

$total=0;
for($a=0;$a<=$#grid;$a++) {
 for($b=0;$b<=$#{$grid[$a]};$b++) {
  if($grid[$a][$b] eq 'X') { $total++ }
  if($grid[$a][$b]) {
   print $grid[$a][$b] if $verbose;
  } else {
   print " " if $verbose;
  }
 }
 print "\n" if $verbose;
}

open(A,$ARGV[0])||die "unable to open $ARGV[0] : $!";
while(<A>) {
 next unless /^#(\d+) +@ +(\d+),(\d+): +(\d+)x(\d+)/;
 $claim=$1;
 $xpos=$2;
 $ypos=$3;
 $width=$4;
 $height=$5;
 $overlap=0;
 for($y=$ypos;$y<$ypos+$height;$y++) {
  for($x=$xpos;$x<$xpos+$width;$x++) {
   if($grid[$y][$x] != $claim) {
    $overlap=1;
   }
  }
 }
 print "claim $claim no overlap\n" if $overlap==0;
}
close A;
