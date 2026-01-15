#!/bin/bash

# ========================================
# Script to uninstall packages, stop services, and clean ports
# ========================================

# Colors
r="\e[31m"
g="\e[32m"
n="\e[0m"

# Root check
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${r}Please run this script as root${n}"
    exit 1
fi

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 package1[:service1] ..."
    echo "Example: ./remove_packages.sh nginx:nginx mysql:mysqld docker:docker"
    exit 1
fi

# Loop through all packages
for ITEM in "$@"; do
    PACKAGE=$(echo "$ITEM" | cut -d':' -f1)
    SERVICE=$(echo "$ITEM" | cut -d':' -f2)

    echo "--------------------------------------"
    echo "Processing package: $PACKAGE, service: $SERVICE"

    # Stop & disable service if it exists
    if [ -n "$SERVICE" ]; then
        systemctl stop "$SERVICE" 2>/dev/null
        systemctl disable "$SERVICE" 2>/dev/null
        echo -e "${g}Service $SERVICE stopped & disabled${n}"
    fi

    # Remove package
    dnf remove -y "$PACKAGE"
    if [ $? -eq 0 ]; then
        echo -e "${g}Package $PACKAGE removed successfully${n}"
    else
        echo -e "${r}Failed to remove $PACKAGE${n}"
    fi

    # Show ports (should be gone)
    if [ -n "$SERVICE" ]; then
        echo "Checking ports for $SERVICE..."
        ss -tulnp | grep "$SERVICE" || echo "No listening ports for $SERVICE"
    fi
done
