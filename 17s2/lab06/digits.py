#!/usr/bin/python

from sys import stdin
from sys import stdout
import re

regex_small = re.compile('[0-4]')
regex_large = re.compile('[6-9]')

for read_line in stdin:
	adjust_line = re.sub(regex_small, '<', read_line)
	adjust_line = re.sub(regex_large, '>', adjust_line)
	stdout.write(adjust_line)
	
