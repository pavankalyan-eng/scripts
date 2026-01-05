#!/bin/bash

userid=$(id -u)
echo "userid: $userid"


if [ $userid -ne 0 ]
then    
    echo "please run this script with root"
    exit 1
fi    


dnf list installed mysql




if [ $? -ne 0 ]
then    
    echo " git not installed going installed"
    dnf install mysql -y
    if [ $? -ne 0 ]
    then    
        echo "installation not success"
        exit 1
    else
        echo "going to install"    
    fi
else
    echo "installed already"  
fi       