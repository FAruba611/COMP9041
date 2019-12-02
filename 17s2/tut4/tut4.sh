#!/bin/sh

# Q1: cd_up.sh
arg=$1

if test $arg == '1'
then
	cd ~/Desktop
fi

# Q2: update_course_code.sh
if test $arg == '2'
then
	cnt=0
	for file in "$@"
	do
		if $cnt -eq 1
		then
			cnt=`expr $cnt + 1`
			continue
		else
			temp_file="$file.tmp.$$"
			if test -e "$temp_file"
			then
				echo "$temp_file" already exists
				exit 1
			fi
			sed "s/COMP2041/COMP2042/g" $file > $temp_file
			sed "s/COMP9041/COMP9042/g" $file > $temp_file
		fi
		cnt=`expr $cnt + 1`
	done
fi

if test $arg == '5'
then
	mlalias COMP2041-list
fi

if test $arg == '6'
then
	zid=$2
	acc $zid | egrep "User classes : (.+)\nMisc classes"
	echo ${SH_REMATCH}
fi




