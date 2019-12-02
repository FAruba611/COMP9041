#!/usr/bin/python3

import sys

word_set = []
data_set = sys.argv[1:]
for item in data_set:
	if item not in word_set:
		word_set.append(item)
    
for item in word_set:
	print(item, end = " ")
print()

