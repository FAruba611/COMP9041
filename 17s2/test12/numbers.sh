#!/bin/sh

i=$1
border=$2

aim_file=$3

while test $i -le $border
do
	echo "$i" >> $aim_file
	i=`expr $i + 1`
done


