#!/bin/bash
LOGFILE="/var/log/auto-update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "---------------------------------------" >> $LOGFILE
echo "Update started at: $TIMESTAMP" >> $LOGFILE

echo "Updating package list..."
apt update -y >> $LOGFILE 2>&1

echo "Upgrading packages..."
apt upgrade -y >> $LOGFILE 2>&1

echo "Performing full upgrade..."
apt full-upgrade -y >> $LOGFILE 2>&1

echo "Cleaning up..."
apt autoremove -y >> $LOGFILE 2>&1
apt autoclean -y >> $LOGFILE 2>&1

echo "Update complete."
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
echo "Finished at: $TIMESTAMP" >> $LOGFILE
echo "---------------------------------------" >> $LOGFILE

echo "All updates completed successfully!"
