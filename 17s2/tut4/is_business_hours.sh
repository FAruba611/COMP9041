#!/bin/sh
!<<eof
Write a shell script, is_business_hours which exits with a status of 0 if the current time
is between 9am and 5pm, and otherwise exit with status of 1
Hint: the date command prints the current time ina format like this
eof

adjust_date="`date|sed 's/\\s+/ /'`"
hr=`echo $adjust_date| cut -d" " -f4 | cut -d":" -f1`
if test $hr -ge 9 && test $hr -le 17 
then
	echo during work hour
	exit 0
else
	exit 1
fi
