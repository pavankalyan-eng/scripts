#!/bin/bash

mkdir -p /opt/health
REPORT_FILE="/opt/health/health_$(date +%F_%H-%M-%S).txt"

# Print to terminal and file
exec > >(tee -a "$REPORT_FILE") 2>&1

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

echo "Report saved to $REPORT_FILE"
echo exit 1
