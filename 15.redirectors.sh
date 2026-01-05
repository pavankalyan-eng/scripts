#!/bin/bash
LOG_FOLDER=$(/var/log/shell)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
DATE=$(date)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME/$DATE/.log"
mkdir -p $LOG_FOLDERuserid=$(id -u)
r="\e[31m]"
g="\e[32m]"
y="\e[33m]"
b="\e[34m]"
echo "userid: $userid"
validate (){
  if [ $1 -ne 0]
  then
    echo -e"\e[32m command is failed" &>>$LOG_FILE
  else
    echo "command sucess"&>>$LOG_FILE

}
USAGE(){
      echo "USAGE: 15.redirectors.sh package1 package2 ... "
      exit 1
}


echo "script executing started $(date)" | tee -a $LOG_FILE  { if u write tee command u forgot &>>}

if [ $userid -ne 0 ]
then    
    echo "please run this script with root" &>>$LOG_FILE
    exit 1
fi 
    if [ $# -eq 0]
    then
        USAGE
    fi    

for package in $@
do 
   dnf list installed $package &>>$LOG_FILE
   if [ $? -ne 0 ]
then    
    echo " $package not installed going installed"&>>$LOG_FILE
    dnf install $package -y &>>$LOG_FILE
   validate $? "listing $package"
else
    echo " $package installed already" &>>$LOG_FILE 
fi 
done