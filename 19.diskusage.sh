#!/bin/bash


DISH_USAGE=$(df -ht | grep xfs)
DISK_THRESHOLD=5




while IFS= read -r line   # deleting files 
do 
    USAGE=$(echo $line | grep xfs | awk -F "" '{print $6F}'| cut -d "%" -f1)
    partion=$(echo $line | grep xfs | awk -F "" '{print $NF}')
    

        if [ $DISH_USAGE -ge $DISK_THRESHOLD ]
        then
            echo "$partion is more then $DISK_THRESHold"
        fi

done <<< $DISH_USAGE