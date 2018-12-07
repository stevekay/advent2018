#!/bin/perl
select(STDERR);
$|++;
select(STDOUT);
$|++;
if($ARGV[1] eq '-v') { $verbose=1 }
print "reading file....";
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
$xmax++;
print "done, xmax=$xmax, ymax=$ymax\n";

# draw grid
#print "grid:\n" if $verbose;
#for($a=0;$a<=$ymax;$a++) {
# print "   " if $verbose;
# for($b=0;$b<=$xmax;$b++) {
#  if($grid[$a][$b]) {
#   print $grid[$a][$b] if $verbose;
#  } else {
#   print "." if $verbose;
#  }
# }
# print "\n" if $verbose;
#}
#print "grid end\n" if $verbose;

print "doing distances...\n";
for($y=0;$y<=$ymax;$y++) {
 print scalar localtime," y=$y\n";
 for($x=0;$x<=$xmax;$x++) {
  print "processing position y=$y x=$x\n" if $verbose;
  $nearest_letter='';
  $nearest_distance=999;
  for($yy=0;$yy<=$ymax;$yy++) {
   for($xx=0;$xx<=$xmax;$xx++) {
    next unless $grid[$yy][$xx];
    $m=abs($xx-$x)+abs($yy-$y);
    #print " at position ($x,$y) : checking against ($xx,$yy) : value ",$grid[$yy][$xx]," distance=$m\n" if $verbose;
    if($m == $nearest_distance) { $nearest_letter='.'; next }
    if($m < $nearest_distance) { 
     $nearest_distance=$m;
     if($m==0) { 
      $nearest_letter=$grid[$yy][$xx];
     } else {
      $nearest_letter=lc($grid[$yy][$xx]);
      $nearest_letter=$grid[$yy][$xx];
     }
    }
   }
  }
  # print "   -> nearest was letter $nearest_letter with distance $nearest_distance\n\n" if $verbose;
  $newgrid[$y][$x]=$nearest_letter;
 }
}
print "done\n";


print "grid:\n" if $verbose;
for($a=0;$a<=$ymax;$a++) {
 print "   " if $verbose;
 for($b=0;$b<=$xmax;$b++) {
  if($newgrid[$a][$b]) {
   print $newgrid[$a][$b] if $verbose;
  } else {
   print "." if $verbose;
  }
 }
 print "\n" if $verbose;
}
print "grid end\n" if $verbose;

# look for any lowercases that reached a permiter
print scalar localtime," looking for perimeter....";
for($y=0;$y<=$ymax;$y++) {
 for($x=0;$x<=$xmax;$x++) {
  if($y==0 || $y==$ymax || $x==0 || $x == $xmax) {
   print "$x,$y,",$newgrid[$y][$x],"\n" if $verbose;
   $good{$newgrid[$y][$x]}++;
  }
 }
}
print "done\n";

# %good has the infinites in
foreach (sort keys %good) {
 print $_,"\n" if $verbose;
}

for($y=0;$y<=$ymax;$y++) {
 for($x=0;$x<=$xmax;$x++) {
  $l=$newgrid[$y][$x];
  next if exists($good{$l});
  next if $l eq '.';
  print "at $x,$y found letter $l, so incrementing counter\n" if $verbose;
  $size{$l}++;
 }
}

foreach (sort keys %size) {
 print "letter $_ size ",$size{$_},"\n";
}
