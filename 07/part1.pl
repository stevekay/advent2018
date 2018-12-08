#!/bin/perl
open(A,$ARGV[0]);
while(<A>) {
 ($dep,$job)=((split(/ /))[1],(split(/ /))[7]);
 $joblist{$job}{$dep}=$chars{$dep}=$chars{$job}='';
}
while(keys %joblist) {
	foreach (sort keys %chars) {
		next if(keys %{$joblist{$_}});
		print;
		$done = $_;
		last;
	}
	delete $joblist{$done};
	delete $chars{$done};
	foreach $job (keys %joblist) {
		for (keys %{$joblist{$job}}) {
			delete $joblist{$job}{$_} if $_ eq $done;
		}
	}
}
