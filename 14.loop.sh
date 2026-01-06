#!/bin/bash

userid=$(id -u)

r="\e[31m"
g="\e[32m"
y="\e[33m"
b="\e[34m"
n="\e[0m"

echo "userid: $userid"

validate () {
  if [ $1 -ne 0 ]
  then
    echo -e "${r}command failed${n}"
  else
    echo -e "${g}command success${n}"
  fi
}

if [ $userid -ne 0 ]
then    
    echo "please run this script with root"
    exit 1
fi
if [ $# -eq 0 ]; then
  echo "Usage: $0 package1 package2 ..."
  exit 1
fi

for package in "$@"
do 
   dnf list installed "$package" &>/dev/null
   if [ $? -ne 0 ]
   then    
      echo "$package not installed, installing..."
      dnf install "$package" -y
      validate $?
   else
      echo "$package already installed"
   fi 
done
