#!/bin/bash

userid=$(id -u)
r="\e[31m]"
g="\e[32m]"
y="\e[33m]"
b="\e[34m]"
echo "userid: $userid"
validate (){
  if [ $1 -ne 0]
  then
    echo -e"\e[32m command is failed"
  else
    echo "command sucess"

}


if [ $userid -ne 0 ]
then    
    echo "please run this script with root"
    exit 1
fi    


dnf list installed mysql
validate $?


if [ $? -ne 0 ]
then    
    echo " mysql not installed going installed"
    dnf install mysql -y
   validate $? "listing mysql"
else
    echo "installed already"  
fi       