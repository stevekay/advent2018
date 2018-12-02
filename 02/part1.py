#!/bin/python
import sys
doubles=triples=0
with open(sys.argv[1]) as fp:
	for line in fp:
		foundadouble=foundatriple=0
		digitcounts = {}
		for char in line:
			if not char in digitcounts:
				digitcounts[char] = 1
			else:
				digitcounts[char] += 1
		for x in digitcounts:
			if digitcounts[x] == 2:
				foundadouble=1
			if digitcounts[x] == 3:
				foundatriple=1
		if foundadouble == 1:
			doubles += 1
		if foundatriple == 1:
			triples += 1
				
print doubles,"*",triples,"=",doubles*triples
