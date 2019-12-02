#!/bin/sh

for selected_jpg in *.jpg
do
    new_suffix='.png'
    #echo "$selected_jpg"
    selected_filename=` echo $selected_jpg | cut -d. -f1 `
    selected_png=${selected_filename}${new_suffix}
    #echo "$selected_png"
    if [ -e "$selected_png" ]
    then
        echo "$selected_png" already exists
        exit 1
    fi
    convert "$selected_jpg" "$selected_png"
done
