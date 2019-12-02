#!/bin/sh

arg=$1

if test $arg == '1'
then
	echo "correct answer should be ./myScript"
fi

if test $arg == '2'
then
	echo "sort cannot solve"
fi

if test $arg == '3a'
then
	fil=$2
	echo "This is Q3a"
	echo "display the first three lines of the file "
	echo
	head -n 3 $2
fi

if test $arg == '3b'
then
	f=$2
	echo "This is Q3b"
	echo "display lines belonging to
		class accounts (assume that their login 
		name starts with either \"cs\", \"se\", \"bi\" or \"en\", 
		followed by a digit)"
	echo
	egrep "(cs|se|bi|en)\d" $f
fi

if test $arg == '3c'
then
	f=$2
	echo "This is Q3c"
	echo "display the user name of everyone 
		whose shell is /bin/bash"
	egrep "/bin/bash" $f
fi

if test $arg == '3d'
then
	f=$2
	echo "This is Q3d"
	echo "create a tab-separated file passwords.txt 
		containing only login name and password for all users "
	cut -d':' -f1,2 $f | tr ":" "\t" > "passwords.txt" ; cat "passwords.txt"
fi

if test $arg == '4'
then
	
	echo "This is Q4"
	echo "create a tab-separated file passwords.txt 
		containing only login name and password for all users "
	for arg in "$@"
	do
		if test -e $arg && test -r $arg
		then
			while read line
			do
				echo "$line"
			done < $arg
		else
			echo "no such files"
		fi
		echo --------------
	done
fi

if test $arg == '5'
then
	cnt=1
	for arg in "$@"
	do
		if test $cnt -gt 1
		then
			fname=`echo "$arg" | sed "s/\.gz//"`
			echo ===== $fname =====
			zcat 
		fi
		cnt=`expr $cnt + 1`
	done

fi


if test $arg == '6'
then
	while read zid name init
	do
		mark=`egrep $zid "Marks" | cut -d" " -f2`
		echo "$mark $name $init"
	done < "Students"
	
fi

if test $arg == '7'
then
	while read zid grade extra
	do
		valid=`echo "$grade" | egrep "[1-9][0-9]*" | wc -l`
		#echo $valid
		if test $valid -eq 1
		then
			if test $grade -le 100 && test $grade -ge 85 
			then
				echo "$zid HD"
			elif test $grade -lt 85 && test $grade -ge 75
			then
				echo "$zid DN"
			elif test $grade -lt 75 && test $grade -ge 65
			then
				echo "$zid CR"
			elif test $grade -lt 65 && test $grade -ge 50
			then
				echo "$zid PS"
			elif test $grade -lt 50 && test $grade -ge 0
			then
				echo "$zid FL"	
			else
				info=$grade
				echo "$zid ?? ($info)"
			fi
		else
			info=$grade
			echo "$zid ?? ($info)"
		
		fi
	done < "Input_grades_Q7"
	
fi

# Q9:
# Write a shell script time_date.sh that prints the time and date 
# once an hour. It should do this until a new month is reached.
# Reminder the date command produces output like this:
# Friday 5 August  17:37:01 AEST 2016
if test $arg == '8'
then
	
	
    
    while test "1" == "1"
    do
        curr_dt="`date`"
        curr_hr=`echo $curr_dt | sed "s/ +/ /g" | cut -d" " -f4 | cut -d":" -f2`
	#echo "+++++$curr_dat"
	#echo "$curr_min"
	if [ "$curr_hr" != "$last_hr" ]
	then
		echo ------
	fi
        last_dt="`date`"
        last_hr=`echo $curr_dt | sed "s/ +/ /g" | cut -d" " -f4 | cut -d":" -f2`

        sleep 5
    done
    
	
fi

# Q10:
if test $arg == '10'
max_byte=100000
then
	
	for file in *
	do
		file_size=`wc -c <"$file"`
		if test $file_size -ge $max_byte
		then
			echo $file
		fi
	done
fi


# Q11:
!<<eof
What is the output of each following pipelines if the text is ----->

this is big Big BIG
but this is not so big

1. tr -d ' ' | wc -w
2. tr -cs 'a-zA-Z0-9' '\n' | wc -l
3. tr -cs 'a-zA-Z0-9' '\n' | tr 'a-z' 'A-Z' | sort | uniq -c

Solution:
1. because delete all ' ', so answer is 2
2. tr -cs means tr elements which are not in 'a-zA-Z0-9' to '\n', So get 11 lines(words), answer is 11
3. based on part 2, then tr all lower alphabetics to upper, then sort by ascending alphabetical order
   So result is 
	4 BIG
	1 BUT
	2 IS
	1 NOT
	1 SO
	2 THIS
eof

# Q12:
!<<eof
Consider the standard "split-into-words" technique from the previous question
	tr -c -s 'a-zA-Z0-9' '\n' <someFile
eof

# Q13:
!<<eof
Assume that we are in a shell where the following shell variable assignments have been performed, and ls gives the following result:
$ x=2 y='Y Y' z=ls
$ ls
	a	b	c
eof











