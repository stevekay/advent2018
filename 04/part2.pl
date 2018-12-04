#!/bin/perl
open(A,"sort < $ARGV[0] |")||die "unable to open $ARGV[0] : $!";
while(<A>) {
 ($kak,$year,$month,$day,$hour,$min)=split(/\[|\-| |:|\]/);
 if(/Guard #(\d+) begins shift/) { $guard=$1 }
 if(/falls asleep/) { $asleep=$min }
 next unless /wakes up/;
 $sleep{$guard}+=--$min-$asleep;
 for $x ($asleep..$min) {
  $a{$guard}{$x}++;
  $b{$x}{$guard}++;
 }
}

foreach $x (sort keys %b) {
 foreach $y (sort keys %{$b{$x}}) {
  if($b{$x}{$y} > $m) {$m=$b{$x}{$y};$g=$y;$c=$x}
 }
}

print "Answer is $g * $c = ",$g*$c,"\n";
