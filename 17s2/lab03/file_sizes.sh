#!/bin/sh

for file_item in *
do
    lines=`wc -l <$file_item`
    if test $lines -ge 100
    then
        l_set="$l_set $file_item"
    elif test $lines -ge 10
    then
        m_set="$m_set $file_item"
    else
        s_set="$s_set $file_item"
    fi
done
echo "small files:$s_set"
echo "Medium-sized files:$m_set"
echo "Large files:$l_set"

exit 0
