#!/usr/bin/python36
import sys

arg = sys.argv[1]

recipes = []
recipes.append(3)
recipes.append(7)

first=0
second=1

while(len(recipes) < int(arg)+12):
	for new in str(recipes[first]+recipes[second]):
		recipes.append(int(new))

	first += recipes[first]+1
	first = first % len(recipes)

	second += recipes[second]+1
	second = second % len(recipes)

print(*recipes[int(arg):int(arg)+10],sep='')
