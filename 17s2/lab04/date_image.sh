#!/bin/sh

for img in "$@"
do
    convert $img $img
    echo "`stat $img`"
    modified_info=`stat $img | grep -i Modify | cut -d\  -f2-3`
    modified_date_last=`echo $modified_info | cut -d\  -f1 | cut -d- -f2-3`
    modified_time_last=`echo $modified_info | cut -d\  -f2 | sed 's/:[0-9][0-9].[0-9]*$//'` 
    modified_month_last=`echo $modified_date_last | cut -d- -f1`
    modified_day_last=`echo $modified_date_last | cut -d- -f2`

    if [ "$modified_month_last" = "01" ]
    then
        modified_tr_month_last='JAN'
    elif [ "$modified_month_last" = "02" ]
    then
        modified_tr_month_last='FEB'
    elif [ "$modified_month_last" = "03" ]
    then
        modified_tr_month_last='MAR'
    elif [ "$modified_month_last" = "04" ]
    then
        modified_tr_month_last='APR'
    elif [ "$modified_month_last" = "05" ]
    then
        modified_tr_month_last='MAY'
    elif [ "$modified_month_last" = "06" ]
    then
        modified_tr_month_last='JUN'
    elif [ "$modified_month_last" = "07" ]
    then
        modified_tr_month_last='JUL'
    elif [ "$modified_month_last" = "08" ]
    then
        modified_tr_month_last='AUG'
    elif [ "$modified_month_last" = "09" ]
    then
        modified_tr_month_last='SEP'
    elif [ "$modified_month_last" = "10" ]
    then
        modified_tr_month_last='OCT'
    elif [ "$modified_month_last" = "11" ]
    then
        modified_tr_month_last='NOV'
    else
        modified_tr_month_last='DEC'
    fi
    
    modified_tr_date_last="$modified_tr_month_last"" $modified_day_last"
    
    temimg="$img.tm.$$" 
    if test -e "$temimg" 
    then 
        echo "$temimg" already exists 
        exit 1 
    fi
    final_painting="$modified_tr_date_last"" $modified_time_last"
    convert -gravity south -pointsize 36 -draw "text 0,10 '$final_painting'" $img $temimg
    mv $temimg $img
    
done
