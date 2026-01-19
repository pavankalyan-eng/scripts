#!/bin/bash
                                        #if [[ -z "$var"]];
                                        #then
                                        #   $var empty or not
                                        #fi

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=14
DATE=$(date)

USAGE(){
    echo -e "usage:18.bachup.sh <source> <destinatin>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE 
fi                                                                               ###exmaple 
                                                                                  #source-dir /home/ec2-user/app-log
                                                                                  #distination-dir /home/ec2-user/backend.log

if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR does not exit .....please check"
fi

if [ ! -d $DEST_DIR ]
then
    echo "$DIST_DIR does not exit .....please check"
fi


files=$(find $SOURCE_DIRECTORY -name "*access" -mtime +14)
echo "files: $files"


if [ ! -z $files ]
then 
    echo "files are found"
    ZIP_FILE="$DEST_DIR -$dat/back.zip"
    find $SOURCE_DIRECTORY -name "*access" -mtime +14 | zip "$ZIP_FILE" -@

    if [ -f $ZIP_FILE ]
    then
        echo "successfully zipped"$days
        
            while IFS= read -r file    # deleting files 
            do 
                echo "deleting file: $file"
                rm -rf $file
            done <<< $files
    else
        echo "zipped unsuccessfully "
    fi
else  
    echo " files not found :$DAYS"
fi