#!/bin/perl
open(A,"sort < " . $ARGV[0]. " |")||die "unable to open $ARGV[0] : $!";
$verbose=$ARGV[1] eq '-v' ? 1 : 0;
while(<A>) {
 ($kak,$year,$month,$day,$hour,$min)=split(/\[|\-| |:|\]/);
 if($_ =~ /Guard #(\d+) begins shift/) {
  $guard=$1;
 }
 if($_ =~ /falls asleep/) {
  $asleep=$min;
 }
 if($_ =~ /wakes up/) {
  $sleep{$guard}+=$min-$asleep-1;
  for $x ( $asleep .. $min - 1 ) {
   $a{$guard}{$x}++;
   $b{$x}{$guard}++;
  }
 }
}
close A;

foreach $x (sort keys %b) {
 foreach $y (sort keys %{$b{$x}}) {
  if($b{$x}{$y} > $m) { $m = $b{$x}{$y}; $g=$y ; $c=$x}
 }
}

print "Answer is $g * $c = ",$g*$c,"\n";
exit;

