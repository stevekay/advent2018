#!/bin/perl
open(A,$ARGV[0]);
$a=<A>;
chomp $a;
@b=split(/ +/,$a);
for $c (0 .. $#b) {
 print "c=$c val=",$b[$c],"\n";
}
$myid=1;

# print header
printf "%c\n",$myid+64;
for(@b) {
 printf "%02d ",$_;
}
print "\n";

$node{$myid}=1;
$node{$myid}{pos}=$c;
$node{$myid}{childcnt}=$b[$c];
$node{$myid}{metacnt}=$b[$c+1];
$node{$myid}{parent}='';

print "childcnt=",$b[$c],"\n";
$c+=2;
for $x ($myid+1 .. $myid+$node{$myid}{childcnt} ) {
	printf " created child %c, childcnt %d metacnt %d parent %c\n",$x+64,$b[$c],$b[$c+1],$myid+64;
	$node{$x}=1;
	$node{$x}{childcnt}=$b[$c];
	$node{$x}{metacnt}=$b[$c+1];
	$node{$x}{parent}=$myid;
	if($node{x}{childcnt} == 0) {
		print "  no children\n";
		# do meta
		for $z ( 1 .. $node{$x}{metacnt} ) {
			print "  meta item $z = ",$b[$c+1+$z],"\n";
		}
	}
}
