#!/bin/sh

for png_suffix_item in $@
do
    echo -n "Address to e-mail this image to? "
    read addr 
    if test -n "$addr" 
    then 
        echo -n "Message to accompany image? " 
        read info 
        echo "$info"| mutt -s 'image' -e 'set copy=no' -a "$png_suffix_item" -- "$addr" 
        echo "$png_suffix_item sent to $addr" 
    else 
        echo "No email sent" 
    fi 
done
