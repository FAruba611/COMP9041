#!/usr/bin/python

import sys

if len(sys.argv) == 3:
	try:
		circulation = int(sys.argv[1])

	except ValueError:
		circulation = "ERROR"

	if isinstance(circulation,int):
		if circulation>=0:
			count = 0
			while count < circulation:
				print(sys.argv[2])
				count+=1
		else:
			print("{}: argument 1 must be a non-negative integer".format(sys.argv[0]))
			sys.exit(1)
	else:
		print("{}: argument 1 must be a non-negative integer".format(sys.argv[0]))
		sys.exit(1)

else:
	print("Usage: {} <number of lines> <string>".format(sys.argv[0]))
	sys.exit(1)
