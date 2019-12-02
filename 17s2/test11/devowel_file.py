#!/usr/bin/python3

import sys,re

file_name = sys.argv[1]
to_be_written_list = []
with open(file_name, "r") as file1:
    for line in file1.readlines():
        stri=""
        for char in line:
            if re.match(r'[^aeiouAEIOU]',char):
                stri += char;
        to_be_written_list.append(stri)

with open(file_name, "w") as file2:
    for adjust_line in to_be_written_list:
        file2.write(adjust_line)
        
