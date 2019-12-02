#!/usr/bin/python3

import sys

lis = []
for x in sys.argv[1:]:
    lis.append(int(x))
sort_lis = sorted(lis)

print(sort_lis[len(sort_lis)//2])