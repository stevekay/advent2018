#!/bin/perl
open(A,$ARGV[0])||die;
while(<A>) {
 unless(/^Step (.) must be finished before step (.) can begin\./) {
  die "bad line $_"
 }
 $dep=$1; # dep = dependency
 $job=$2; # job = actual job

 $joblist{$job}{$dep}='x';
 $chars{$dep}='y';
 $chars{$job}='y';
}

$answer='';
while(keys %joblist) {
	foreach $job (sort keys %chars) {
		next if(keys %{$joblist{$job}});
		$answer .= $job;
		$done = $job;
		last;
	}

	delete $joblist{$done};
	delete $chars{$done};

	foreach $job (keys %joblist) {
		for $dep (keys %{$joblist{$job}}) {
			if($dep eq $done) {
				delete $joblist{$job}{$dep};
			}
		}
	}
}

print "$answer\n";
