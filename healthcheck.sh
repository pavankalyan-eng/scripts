#!/bin/bash

REPORT_FILE="/root/system_report.txt"

# Redirect stdout and stderr to the report file
exec > "$REPORT_FILE" 2>&1

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
dnf list installed | wc -l
echo

echo "Currently logged in:"
who
echo

echo "Listing users:"
cut -d: -f1 /etc/passwd
echo

echo "Report saved to $REPORT_FILE"
