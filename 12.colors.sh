#!/bin/bash

userid=$(id -u)
echo "userid: $userid"
validate (){
  if [ $1 -ne 0]
  then
    echo "command is failed"
  else
    echo "command sucess"

}


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
   validate $? "listing git"
else
    echo "installed already"  
fi       