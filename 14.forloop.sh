#!/bin/bash

# ========================================
# Script to auto-install packages, start service, and show listening ports
# ========================================

# Colors
r="\e[31m"
g="\e[32m"
y="\e[33m"
b="\e[34m"
n="\e[0m"

# Check if root
userid=$(id -u)
echo "UserID: $userid"

if [ $userid -ne 0 ]; then
    echo -e "${r}Please run this script as root${n}"
    exit 1
fi

# Function to validate command execution
validate () {
  if [ $1 -ne 0 ]; then
    echo -e "${r}Command failed${n}"
  else
    echo -e "${g}Command success${n}"
  fi
}

# Check arguments
if [ $# -eq 0 ]; then
  echo "Usage: $0 package1 package2 ..."
  exit 1
fi

# Loop through all packages
for package in "$@"; do
    echo "--------------------------------------"
    echo "Processing package: $package"

    # Check if package installed
    dnf list installed "$package" &>/dev/null
    if [ $? -ne 0 ]; then
        echo "$package not installed. Installing..."
        dnf install -y "$package"
        validate $?

        echo "Enabling & starting $package service..."
        systemctl enable "$package" --now
        validate $?
    else
        echo "$package is already installed"
        echo "Ensuring $package service is enabled & running..."
        systemctl enable "$package" --now
        validate $?
    fi

    # Show listening ports for this package/service
    echo "Ports for $package (if any):"
    ss -tulnp | grep "$package" || echo "No listening ports found for $package"

done
