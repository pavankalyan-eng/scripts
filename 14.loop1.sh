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

for package in $@
do 
   dnf list installed $package
   if [ $? -ne 0 ]
then    
    echo " $package not installed going installed"
    dnf install $package -y
   validate $? "listing $package"
else
    echo " $package installed already"  
fi 
done