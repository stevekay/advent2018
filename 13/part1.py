#!/usr/bin/python36
import sys

grid=[]
carts=[]

# read the file
with open(sys.argv[1]) as fp:
	for line in fp:
		grid.append(list(line[:-1]));

# find carts, create carts array
for y in range(0,len(grid)):
	for x in range(0,len(grid[y])):
		c = grid[y][x]
		if c == 'v':
			carts.append( [ y,x,"S",0 ])
			grid[y][x]='|'
		elif c == '^':
			carts.append( [ y,x,"N",0 ])
			grid[y][x]='|'
		elif c == '<':
			carts.append( [ y,x,"W",0 ])
			grid[y][x]='-'
		elif c == '>':
			carts.append( [ y,x,"E",0 ])
			grid[y][x]='-'

while(1):

	carts = sorted(carts, key = lambda x: (x[0], x[1]))

	for a in range (0,len(carts)):
		y=carts[a][0]
		x=carts[a][1]
		dir=carts[a][2]
		turn=carts[a][3]

		if grid[y][x] == '+':
			if dir == 'E':
				if turn==0:
					dir = 'N'
				if turn==2:
					dir = 'S'
			elif dir == 'W':
				if turn==0:
					dir = 'S'
				if turn==2:
					dir = 'N'
			elif dir == 'N':
				if turn==0:
					dir = 'W'
				if turn==2:
					dir = 'E'
			elif dir == 'S':
				if turn==0:
					dir = 'E'
				if turn==2:
					dir = 'W'
			turn+=1
			if turn == 3:
				turn=0
		if dir == 'E':
			x += 1
			if grid[y][x] == '\\':
				dir='S'
			if grid[y][x] == '/':
				dir='N'
		elif dir == 'W':
			x -= 1
			if grid[y][x] == '\\':
				dir='N'
			if grid[y][x] == '/':
				dir='S'
		elif dir == 'N':
			y -= 1
			if grid[y][x] == '/':
				dir='E'
			if grid[y][x] == '\\':
				dir='W'
		elif dir == 'S':
			y += 1
			if grid[y][x] == '/':
				dir='W'
			if grid[y][x] == '\\':
				dir='E'

		for z in carts:
			if z[0] == y and z[1] == x:
				sys.exit("collision at %d,%d" % ( x,y ))

		carts[a][1]=x
		carts[a][0]=y
		carts[a][2]=dir
		carts[a][3]=turn
