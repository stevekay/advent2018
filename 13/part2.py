#!/usr/bin/python36
import sys

grid=[]
carts=[]
removals=[]
firstcollision=1

turndetails = { 'E': 'NES', 'W': 'SWN', 'N': 'WNE', 'S': 'ESW' }
cornerdetails = { 'E': { '\\': 'S', '/': 'N', '-':'E', '+':'E', 'x':1, 'y':0 },
                  'W': { '\\': 'N', '/': 'S', '-':'W', '+':'W', 'x':-1, 'y':0 },
                  'N': { '/': 'E', '\\': 'W', '|':'N', '+':'N', 'x':0, 'y':-1 },
                  'S': { '/': 'W', '\\': 'E', '|':'S', '+':'S', 'x':0, 'y':1 } }

# read the file
with open(sys.argv[1]) as fp:
	for line in fp:
		grid.append(list(line[:-1]));

# find carts, create carts array
for y in range(0,len(grid)):
	for x in range(0,len(grid[y])):
		c = grid[y][x]
		if c in [ 'v', '^', '<', '>']:
			carts.append( [ y,x,c.translate(str.maketrans('v^<>','SNWE')),0 ])
			grid[y][x]=c.translate(str.maketrans('v^<>','||--'))

while(len(carts)>1):
	carts = sorted(carts, key = lambda x: (x[0], x[1]))

	for a in range (0,len(carts)):
		y, x, dir, turn = carts[a]

		if grid[y][x] == '+':
			dir = turndetails[dir][turn%3]
			turn += 1

		dir = cornerdetails[dir][grid[y][x]]
		x += cornerdetails[dir]['x']
		y += cornerdetails[dir]['y']

		for z in carts:
			if z[0] == y and z[1] == x:
				if firstcollision:
					print("first collision at (%d,%d)" %(x,y))
					if len(carts) == 2:
						sys.exit("no carts left")
					firstcollision = 0
				removals.append(z)
				removals.append(carts[a])

		carts[a][1] = x
		carts[a][0] = y
		carts[a][2] = dir
		carts[a][3] = turn

	if removals:
		carts = [e for e in carts if e not in removals]
		removals = []

print("last cart is (%d,%d)" % (carts[0][1],carts[0][0]) )
