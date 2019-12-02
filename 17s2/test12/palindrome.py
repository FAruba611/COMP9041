#!/usr/bin/python3

import sys,re
string = ""
for item in sys.argv[1:]:
	string += item.upper()

string = re.sub("\s+","",string)
string = re.sub("\W","",string)
#print(string)
time = len(string) // 2

count=0

for i in range(time):
	if string[i] == string[-1-i]:
		count+=1


if count == time:
	print("True")
else:
	print("False")


