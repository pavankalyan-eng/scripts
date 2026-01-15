#!/bin/bash

echo "===== SYSTEM HEALTH CHECK ====="
date
echo

echo "Uptime:"
uptime
echo

echo "CPU Load:"
top -b -n1 | head -5
echo

echo "Memory Usage:"
free -h
echo

echo "Disk Usage:"
df -h
echo 

echo "ports"
netstat -lntp
echo

echo "installed packages"
dnf list installed | wc -l
echo

echo "currently logged in"
who 
echo 

echo "listing users"
cut -d: -f1 /etc/passwd | wc -l
echo
  

  echo > health.txt