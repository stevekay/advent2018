#!/bin/perl
#
# Very messy, but works

$steptime=60;
#$steptime=0; # time to action a step, 0 in example, 60 for real

$elves=5;
#$elves=2; # number of elves, 2 in example, 5 for real

open(A,$ARGV[0]);
while(<A>) {
 ($dep,$job)=((split(/ /))[1],(split(/ /))[7]);
 $joblist{$job}{$dep}=$chars{$dep}=$chars{$job}='';
}
for $elfcount (1 .. $elves) {
 #print "Setting elf $_ to be available in 0 seconds\n";
 $elf{$elfcount}{avail}=0;  # seconds count at which elf is available
 $elf{$elfcount}{proj}='.'; # which project that elf is working on
}

$second=0;
$done='';
print "Second   Worker 1    Worker 2    Done\n";
while(keys %joblist) { # while theres still outstanding jobs

	# look for a job which has no dependencies
	foreach $char (sort keys %chars) {
		#print "char=$char\n";
		next if %{$joblist{$char}};
		#print " job $char has no dependencies right now\n";

		# do we have an elf available ?
		for $elfcount (1 .. $elves) {
			#print " -> checking elf $elfcount avail=",$elf{$elfcount}{avail},"\n";
			if($elf{$elfcount}{avail} <= $second) {
				#print "  -> allocating\n";
				$elf{$elfcount}{avail}=$second + $steptime + ord($char) - 64;
				$elf{$elfcount}{proj}=$char;
				#print "    -> is next available ",$elf{$elfcount}{avail},"\n";

				# proj C isnt finished yet, but dont go allocating it to anyone else
				delete $chars{$char};
				last;
			}
		}
	
	}


	printf "%4d%9s%12s        %-10s\n",$second,$elf{1}{proj},$elf{2}{proj},$done;

	$second++;

	# any jobs now finished ?
	for $elfcount ( 1 .. $elves) {
		#print "checking elv $elfcount for finished jobs\n";
		if($elf{$elfcount}{avail} == $second && $elf{$elfcount}{proj} ne '.') {
			#print " -> time to mark elf as available and mark project ",$elf{$elfcount}{proj}," as finished\n";

			$elf{$elfcount}{avail}=0;

			$a=$elf{$elfcount}{proj};
			$anyjobs=0;
			foreach $x ( sort keys %joblist ) {
				#print "x=$x\n";
				foreach $y ( sort keys %{$joblist{$x}} ) {
					$anyjobs=1;
					#print " y=$y val ",$joblist{$x}{$y},"\n";
					if($y eq $a) {
						#print "  -> deleted\n";
						delete $joblist{$x}{$y};
					}
				}
			}
			$done .= $a;
				
			$elf{$elfcount}{proj}='.';
			if($anyjobs==0) { 
				printf "%4d%9s%12s        %-10s\n",$second,$elf{1}{proj},$elf{2}{proj},$done;
				exit;
			}
			
		}
	}
}
