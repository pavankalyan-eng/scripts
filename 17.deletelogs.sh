#!/bin/bash
SOURCE_DIRECTORY=/home/ec2-user/log/



if [ -d $SOURCE_DIRECTORY]  ----> #-d meand check directory exit or NOT
then
    echo -e "$SOURCE_DIRECTORY EXIT"
else    
    echo -e "$SOURCE_DIRECTORY  NOT EXIT"
fi


files=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)
echo "files: $files"


while IFS= read -r file    # deleting files 
do 
    echo "deleting file: $file"
    rm -rf $file
done <<< $files