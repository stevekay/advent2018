#!/bin/perl
open(A,"sort < $ARGV[0] |")||die "unable to open $ARGV[0] : $!";
while(<A>) {
 ($kak,$year,$month,$day,$hour,$min)=split(/\[|\-| |:|\]/);
 if(/Guard #(\d+) begins shift/) {$guard=$1}
 if(/falls asleep/) {$asleep=$min}
 next unless /wakes up/;
 $sleep{$guard}+=--$min-$asleep;
 for $x ($asleep..$min) {$a{$guard}{$x}++}
}

# find guard who slept most
foreach $guard (sort keys %sleep) {
 if($sleep{$guard} > $maxsleep) {$maxsleep=$sleep{$guard};$sleepiest=$guard}
}

# find minute guard was asleep most
foreach $x (sort keys $a{$sleepiest}) {
 if($a{$sleepiest}{$x} > $minute) {$minute=$a{$sleepiest}{$x};$y=$x}
}
 
print "Answer is $sleepiest * $y = ",$sleepiest * $y,"\n";
