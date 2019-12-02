#!/bin/sh

src_file="$@"
#cat $@
for src_file in "$@"
do
	while read line
	do
		if [ `echo $line | wc -L` -lt 8 ]
		then
			#this line's length is shorter than 8
			:
		elif [ `echo $line | wc -L` -ge 8 ]
		then	
			if [ "`echo $line | cut -c1-8`" = "#include" ] # compulsory to add "" on the both side
			then
				#line length greater and equal to 8 which starts with #include
				inc_file=`echo $line | cut -d\  -f2 | egrep -o '[A-Z.a-z]*'` #get rid of "" or <>
				file_tag=`echo $line | cut -c10` # only select "" or <>
			
				if [ -e $inc_file -a $file_tag = "\"" ]||[ $file_tag = "<" ]
				then
					#find the file
					:
				else
					echo $inc_file included into $src_file does not exist
				fi
			else
				#other line length greater and equal to 8 which not starts with #include
				:
			fi
		else
			exit 1
		fi
			
	done < "$src_file"

done
