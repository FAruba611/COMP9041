#!/usr/bin/python

import re, sys

pods = {}
idiv = {}
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
        #print("current_line = {}".format(line))
        species = line.strip()
        if species in pods:
            pods[species] += 1
            idiv[species] += cnt
        else:
            pods[species] = 1
            idiv[species] = cnt
        #print("count = {}".format(count))
        #print("spe = {}".format(species))
    else:
        print("Sorry couldn't parse: {}".format(line))
        

for species in sorted(pods):
    print("{} observations: {} pods, {} individuals".format(species, pods[species],idiv[species]))
