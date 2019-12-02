#!/usr/bin/python
import re, sys
if len(sys.argv) != 2:
    print("Usage: {} <whale species>\n".format(sys.argv[0]))
    sys.exit(1)
t_species = sys.argv[1]
pods = 0;idiv = 0
syntax = re.compile(r'^\s*(\d+)\s*(.+)$')
for line in sys.stdin:
	if (re.match(syntax, line)):
		#print("-----------------")
		line = line.lower()
		tr_to_single = re.compile(r's(\s*)$')
		del_space_to_single = re.compile(r'\s+')
		del_cnt = re.compile(r'^\s*(\d+)\s*')
		cnt = int(re.search(r'(\d+)\s*',line).group(0))
		line = re.sub(del_space_to_single, ' ', line)
		line = re.sub(del_cnt, '', line)
		line = re.sub(tr_to_single, '\n', line)
		species = line.strip()
    
		if species == t_species:
			pods += 1
			idiv += cnt
print("{} observations: {} pods, {} individuals".format(t_species, pods, idiv))
