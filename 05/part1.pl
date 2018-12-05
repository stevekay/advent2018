#!/bin/perl
$r='(';
for $c ( 'a' .. 'z' ) {
 $r .= $c . uc($c) . '|' . uc($c) . $c . '|';
}
$r=~s/.$/)/;
open(A,$ARGV[0]);
$_=<A>;
while(s/$r//g){}
print length()-1;
