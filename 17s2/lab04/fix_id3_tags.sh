#!/bin/sh 

for album_path in "$@" 
do

    album=`basename "$album_path"` 
    year=`echo "$album" | sed 's/.* //'`
    
    search_suffix="/*.mp3"
    for mp3_path in "$album_path"$search_suffix
    do 
        
        if [ `echo "$mp3_path" | egrep '\*.mp3'` ]
        then
            :
        else
            mp3_filename=`echo $mp3_path | sed 's/.*\///'`
            track=`echo "$mp3_filename" | cut -d- -f1`
            
            title=`echo "$mp3_filename" | cut -d- -f2 | sed 's/ //'` 
            artist=`echo "$mp3_filename" | cut -d- -f3 | sed 's/.mp3$//' | sed 's/ //'`
            #echo $track
            #echo $title
            #echo $artist
        fi 
        id3 -y "$year" "$mp3_path" >/dev/null
        id3 -a "$artist" "$mp3_path" >/dev/null
        id3 -t "$title" "$mp3_path" >/dev/null
        id3 -T "$track" "$mp3_path" >/dev/null
        id3 -A "$album" "$mp3_path" >/dev/null
        
    done
done

