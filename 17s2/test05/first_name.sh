#!/bin/sh



#egrep "COMP[29]041" $1 | cut -d\| -f3 | cut -d, -f2 | egrep -o "^\ [A-Za-z]*\ " | sort | uniq -c | sort -nr | head -1 | sed "s/\ *[0-9]*\ *//"

declare -A S
declare -A U
while read line
do
	if [ `echo "$line" | cut -d\| -f1 | egrep "COMP[29]041"` ]
	then
		export str=`echo "$line" | cut -d\| -f3 | cut -d, -f2 | egrep -o "^\ [A-Za-z]*\ "`$str
		#echo current a = $a
		#echo --------------------
	fi	
	
done < $1

read -a name <<< $str
#echo "${#name[@]}"
#echo $len
max_name_cnt=0
#echo "${name[*]}"
for var in ${name[*]}
do
	#echo current_var = $var	
	let S[$var]+=1  #NAME DICTIONARY UPDATE
	if [[ ${max_name_cnt} -le ${S[${var}]} ]]  #UPDATE MAX VALUE
	then
		max_name_cnt=${S[$var]}
		U[$var]=$max_name_cnt
	fi
	#echo ${S[$var]}
done
#echo "${U[*]}"
for key in $(echo ${!U[*]})
do
	#echo "$key : ${U[$key]}"
	#echo $max_name_cnt
	if [[ ${U[$key]} -eq ${max_name_cnt} ]]
	then
		echo $key
		exit 0
	fi
done

#echo ${!S[*]} ------------------- ${S[@]}
#echo "${#S[@]}"
#echo $max_name_cnt
#awk -v a_name="${#name[*]}" 'BEGIN{for(i=1;i<=10;++i){index=a_name[i];print index;S[index]++}END{for(item in S)print item,S[item]}'

