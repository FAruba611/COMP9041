#!/bin/sh
tr '012346789' '<<<<<>>>>'
:<<eof
read -p var
for digit in var
do
    if od var >= 48 && od var <=52
    then
        tr var '<'
    fi
    if od var >= 54 && od var <= 57
    then
        tr var '>'
    fi


val = '123456789'
echo ${val//4/<}

for digit in `seq ${#val}`
do
    if $digit in ['0','1','2','3','4']
    then
       $digit eq '<'

    fi
    if $digit in ['6','7','8','9']
    then
       $digit eq '>'
    fi
done
echo $val
eof

