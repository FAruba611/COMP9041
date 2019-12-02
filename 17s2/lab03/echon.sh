#!/bin/bash 
########

if test $# != 2
then
    echo "Usage: $0 <number of lines> <string>"
    exit 1

else
    if test "$1" -lt 0 2>/dev/null
    then
        echo "$0: argument 1 must be a non-negative integer"
        exit 1
    else
        echo_time=$1
        content=$2
        for ((cir=1; cir<=$echo_time; cir++)) 
        do
            echo $content
        done
    fi
fi
exit 0












