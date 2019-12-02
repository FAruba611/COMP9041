#!/bin/sh 

argu=$1

# 5a
if test $argu == "5a"
then
	echo "--> This is Q5a:"
	egrep "^\s*[#][^#]*"
fi 

# 5b
if test $argu == "5b"
then
	echo "--> This is Q5b:"
	egrep "^\s*[^#].*"
fi 

# 5c
if test $argu == "5c"
then
	echo "--> This is Q5c:"
	egrep "^[^\\\s]*\s+$"
fi 

# 5d
if test $argu == "5d"
then
	echo "--> This is Q5d:"
	egrep "^[BHLP]arry$"
fi 

# 5e
if test $argu == "5e"
then
	echo "--> This is Q5e:"
	egrep "hello\s*world"
fi 

# 5f
if test $argu == "5f"
then
	echo "--> This is Q5f:"
	egrep "c[ae]l[ae]nd[ae]r"
fi

# 5g
if test $argu == "5g"
then
	echo "--> This is Q5g:"
	egrep "^[1-9](,[1-9])*$"
fi

# 5h
if test $argu == "5h"
then
	echo "--> This is Q5h:"
	#egrep "^abc$|^def$"
	egrep "^\"[^\"]+\\n\"$|^'[^\"']+\\n'$"
fi

# 6
if test $argu == "6"
then	
	file=$2
	echo "--> This is Q6:"
	#egrep "^abc$|^def$"
	egrep -i "<\s*(p|br)[^<>]*>" $file
fi

# 7
if test $argu == "10"
then	
	echo "--> This is Q10:"
	#egrep "^abc$|^def$"
	egrep "^129\.94\.172\.([1-9]|[1][0-9]|[2][0-5])$"
fi










