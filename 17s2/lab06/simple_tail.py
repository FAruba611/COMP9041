#!/usr/bin/python

import sys
import linecache
count = 0
content_list = []
for file_name in sys.argv:
	if count == 0:
		count += 1
		continue
	with open(file_name) as file:
		content_list = linecache.getlines(file_name)
		for select_line in content_list[-10:]:
                        adjust_line = str(select_line)[:-1]
			print(adjust_line)
