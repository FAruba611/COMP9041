#!/usr/bin/python3

import sys,re

line_cnt = 0
final_data = []

def deal_line(line):
	line = re.sub(r'(\s)+',' ',line)
	line = re.sub(r'^(\s)*','',line)
	line = re.sub(r'(\s)*$','',line)
	l = line.split(r"$")
	line_after = l[0]
	return line_after

try:
	while True:
		line = input()
		line = deal_line(line)
		select_word = []
		for word in line.split(" "):
			differ = []
			dict_count = {}
			for i in range(len(word)):
				char = word[i].upper()
				#print("------",word[i],"---")
				if char not in dict_count.keys():
					dict_count.update({char:0})
				else:
					dict_count[char]+=1
			for k in dict_count.keys():
				if dict_count[k] not in differ:
					differ.append(dict_count[k])
			if len(differ) == 1:
				select_word.append(word)
		final_data.append(select_word)

except EOFError:
	#print(final_data)
	for i in range(len(final_data)):
		for j in range(len(final_data[i])):
			print("{} ".format(final_data[i][j]),end = "")
		print("\n", end ="")
	