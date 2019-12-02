#!/bin/sh

target_file=$1
l=""
while read line
do
	a=`echo "$line" | sed 's/[aeiouAEIOU]//g'`
	l="$l$a\n"
done < "$target_file"
#echo $l
l=`echo "$l" | sed 's/\\\n$//g'`
#remind that difference betweem echo "$1", echo $1
#echo $l
#echo -e "----\n$l"
echo -e "$l" > $target_file


