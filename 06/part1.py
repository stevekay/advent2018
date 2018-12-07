#!/bin/python
import sys
maxx=-1
maxy=-1
with open(sys.argv[1]) as fp:
	for line in fp:
		xpos=int(line.split(", ")[0])
		if(xpos>maxx):
			maxx=xpos
		ypos=int(line.split(", ")[1])
		if(ypos>maxy):
			maxy=ypos

print "done, got size of array ",xpos,ypos

# populate array
print "populating array"
#g=[]
#for x in range(maxx):
#	for y in range(maxy):
#		g.append([x,y])
#
print "declaring list size ",maxx,"by",maxy
#g = [[0] * maxx] * maxy
g = [[0] * (maxx+2)] * (maxy+2)

#g[3][3]=123
#
#print(g[3][3])


v = 1
with open(sys.argv[1]) as fp:
	for line in fp:
		print line
		xpos=int(line.split(", ")[0])
		ypos=int(line.split(", ")[1])
		g[xpos][ypos]=v
		v += 1

# print grid
for y in range(maxy):
	print "line",y
	for x in range(maxx):
		print g[x][y]
