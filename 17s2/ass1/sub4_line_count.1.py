#!/usr/bin/python3
# written by andrewt@cse.unsw.edu.au as a COMP2041 lecture example
# Count the number of lines on standard input.

import sys
a = 2

lines = sys.stdin.readlines()
line_count = len(lines)
print("%d %d lines" % (line_count,a))
