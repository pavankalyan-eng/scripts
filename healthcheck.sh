#!/bin/bash

mkdir -p /opt/health
Health_file="/opt/health/health_$(date +%F_%H-%M-%S).txt"

# Print to terminal and file
exec > >(tee -a "$Health_file") 2>&1

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

echo "Ports:"
netstat -lntp
echo

echo "Installed packages:"
dnf list installed  | wc -l
echo

echo "Currently logged in:"
who
echo

echo "Listing users:"
cut -d: -f1 /etc/passwd
echo

echo "Report saved to $Health_file"
rsync -avz $Health_file  pavan@192.168.74.140:/opt/health &>> $Health_file
 exit 1
