#!/usr/bin/python3

import sys,re

m_list = []
def deal_item(item):
        item = re.sub(r'(\s)+',' ',item)
        item = re.sub(r'^(\s)*','',item)
        item = re.sub(r'(\s)*$','',item)
        
        item = item.strip()
        return item

for i in sys.stdin.readlines():
	j = deal_item(i)
	m_list.append(j)

i = 0
while i < len(m_list):
        str_list = sorted(m_list[i].split(" "))
        for part in str_list:
                print(part,end=" ")
        print()
        i+=1

	
