#!/bin/perl
open(A,$ARGV[0]);
$label='A';
while(<A>) {
 chomp;
 $line=$_;
 ($x,$y)=split(/, /);
 if($x > $xmax) { $xmax=$x }
 if($y > $ymax) { $ymax=$y }
 $grid[$y][$x]=$label;
 $label++;
}

# draw grid
for($a=0;$a<=$ymax;$a++) {
 for($b=0;$b<=$xmax;$b++) {
  if($grid[$a][$b]) {
   print $grid[$a][$b];
  } else {
   print ".";
  }
 }
 print "\n";
}


#
