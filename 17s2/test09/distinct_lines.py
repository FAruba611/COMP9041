#!/usr/bin/python3

import sys,re

end_tag = int(sys.argv[1])
final_data = []
line_cnt = 0

def deal_line(lines):
        lines = re.sub(r'(\s)+',' ',lines)
        lines = re.sub(r'^(\s)*','',lines)
        lines = re.sub(r'(\s)*$','',lines)
        lines = lines.strip()
        d = lines.split(r"$")
        element = d[0]
        doc = element.lower()
        return doc

try:
    while True:
        lin = input()
        line_cnt+=1
        x = deal_line(lin)
        #print(lines)
        
        
        #print("---",doc)
        
        if x not in final_data:
            final_data.append(x)
        #print(concise_data)
        
        length = len(final_data)
        if end_tag == length:
            print("%d distinct lines seen after %d lines read." % (end_tag,line_cnt))
            sys.exit()

except EOFError:
    print("End of input reached after %d lines read -  %d different lines not seen." % (line_cnt,end_tag))
    sys.exit()
