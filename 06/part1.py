#!/bin/python3.6
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

# populate array
#g=[]
#for x in range(maxx):
#	for y in range(maxy):
#		g.append([x,y])
#
print("declaring list size ",maxx,"by",maxy)
g = [[0] * (maxx+2)] * (maxy+2)

#g[3][3]=123
#
#print(g[3][3])


v = 1
with open(sys.argv[1]) as fp:
	for line in fp:
		xpos=int(line.split(", ")[0])
		ypos=int(line.split(", ")[1])
		print("setting pos",xpos,",",ypos,"to",v)
		g[ypos][xpos]=v
		v += 1

g[0][0]=22
g[0][1]=33
g[0][2]=44
g[0][3]=55

print("g 0,0=",g[0][0])
print("g 0,1=",g[0][1])
print("g 0,2=",g[0][2])
print("g 0,3=",g[0][3])
print("g 0,4=",g[0][4])

print("g 1,0=",g[1][0])
print("g 1,1=",g[1][1])
print("g 1,2=",g[1][2])

print("g 2,0=",g[2][0])
print("g 2,1=",g[2][1])
print("g 2,2=",g[2][2])
# print grid
#for y in range(10):
#	print "line=",y
#	for x in range(maxx):
#		print "y=",y,"x=",x,"value",g[x][y]
#
#	for x in range(maxx):
##		print " x=",x,"value=",g[y][x]
