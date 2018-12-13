#!/bin/perl
$marble=0;
$players=9;

#data as at step 3

# 0
$m{$marble}=1;
$m{$marble}{next}=2;
$m{$marble}{last}=0;

# 1
$marble++;
$m{$marble}=1;
$m{$marble}{next}=2;
$m{$marble}{last}=0;

# 2
$marble++;
$m{$marble}=1;
$m{$marble}{next}=1;
$m{$marble}{last}=2;

# 3
$marble++;
$m{$marble}=1;
$m{$marble}{next}=0;
$m{$marble}{last}=1;

$curr=3;

# output list, should result in
#
# [3]  0  2  1 (3)
$player=3;
printf "[%d] ",$player;

$a=0;

print $a," ";
print $m{$a}{next},"\n";

