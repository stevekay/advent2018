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
  }
 }
}
close A;

# find guard who slept most
foreach $g (sort keys %sleep) {
 if($sleep{$g} > $maxsleep) { $maxsleep=$sleep{$g} ; $sleepiest=$g }
}

# find minute guard was asleep most
foreach $x (sort keys $a{$sleepiest}) {
 if($a{$sleepiest}{$x} > $minute) { $minute=$a{$sleepiest}{$x} ; $y=$x }
}
print "sleepiest was guard $sleepiest with $maxsleep minutes\n";

print "minute was $y with value $minute\n";
 
print "answer is $sleepiest * $y = ",$sleepiest * $y,"\n";
exit;

