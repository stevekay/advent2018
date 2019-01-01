#!/usr/bin/python36
import sys

arg = sys.argv[1]

def printit():
#	print(" array is now",recipes," first=",first,"second=",second)
	out="   "
	print("len=",len(recipes))
	for a in range(0,len(recipes)):
		if a == first:
			out=out+"("+str(recipes[a])+")"
		elif a == second:
			out=out+"["+str(recipes[a])+"]"
		else:
			out=out+" "+str(recipes[a])+" "
	print(out)

recipes = []
recipes.append(3)
recipes.append(7)

first=0
second=1

counter=0
while(len(recipes) < int(arg)+12):
	counter += 1
	#if counter % 500 == 0:
	#	print("done counter",counter)

	#print(counter,": starts")
	#printit()

	#print("total is",recipes[first],"+",recipes[second],"=",recipes[first]+recipes[second])

	total=recipes[first] + recipes[second]
	#print("first=",first,"second=",second)
	for new in str(total):
		#print(" -> added recipe with score",new)
		recipes.append(int(new))
	#print("first=",first,"second=",second)

	#print("  first elf at position",first,"moving by",recipes[first]+1,"steps")
	first += recipes[first]+1
	#print(" new first=",first)
	if first >= len(recipes):
		#print("  too high, as length of recipes is ",len(recipes))
		first = first % len(recipes)
		#print("   now revised to be ",first)

	#print("  second elf at position",second,"moving by",recipes[second]+1,"steps")
	second += recipes[second]+1
	#print(" new second=",second)
	if second >= len(recipes):
		#print("  too high, as length of recipes is ",len(recipes))
		second = second % len(recipes)
		#print("   now revised to be ",second)

foo = ""
for i in range(int(arg),int(arg)+10):
	foo = foo+str(recipes[i])

print("answer=",foo)
