#!/bin/sh

for file_o in *
do
	suffix_html=".html"
	suffix_htm=".htm"
	file_name=`echo "$file_o" | sed 's/\..*$//'`
	file_suffix=`echo "$file_o" | cut -d. -f2`
	#echo --------current filep = $file_o ------------
	#echo -----current filename = $file_name
	file_composite_html=$file_name$suffix_html
	file_composite_htm=$file_name$suffix_htm
	#echo -----$file_composite_html ----- $file_composite_htm
	if [ -e "$file_composite_html" ]
	then
		if [ -e "$file_composite_htm" -a $file_suffix = "htm" ]
		then
		
			#echo "-------------------------------"
			#echo "$file_o"
			echo "$file_composite_html" exists
			#rm $file_o
			:
		fi
	else
		if [ -e "$file_composite_htm" -a $file_suffix = "htm" ]
		then
			mv -f "$file_o" "$file_composite_html"
			:
		fi
	fi
done
exit 1
