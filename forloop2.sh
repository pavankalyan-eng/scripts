#!/bin/bash

# Config
EMAIL="pavan667204@gmail.com"
HOST=$(hostname)
TIME=$(date)

# Root check
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Validate arguments
if [ $# -lt 1 ]; then
  echo "Usage: $0 package1[:service1][:port] ..."
  echo "Example: ./auto_monitor.sh nginx:nginx:80 mysql:mysql:3306 nagios:nagios:"
  exit 1
fi

ALERT=false
MAIL_BODY="Service Alert on $HOST at $TIME\n\n"

# Loop through all packages
for ITEM in "$@"; do
  PACKAGE=$(echo "$ITEM" | cut -d':' -f1)
  SERVICE=$(echo "$ITEM" | cut -d':' -f2)
  PORT=$(echo "$ITEM" | cut -d':' -f3)

  echo "--------------------------------------"
  echo "Processing package: $PACKAGE, service: $SERVICE, port: $PORT"

  # Add EPEL for nagios automatically
  if [[ "$PACKAGE" == "nagios" ]]; then
    dnf install -y epel-release
  fi

  # Check if package installed
  if ! dnf list installed "$PACKAGE" &>/dev/null; then
    echo "$PACKAGE not installed. Installing..."
    dnf install -y "$PACKAGE"
    if [ $? -ne 0 ]; then
      echo "❌ Failed to install $PACKAGE. Skipping..."
      ALERT=true
      MAIL_BODY+="Package $PACKAGE could not be installed\n-----------------------------------\n"
      continue
    fi
  else
    echo "$PACKAGE already installed"
  fi

  # Enable & start service if service name provided
  if [ -n "$SERVICE" ]; then
    systemctl enable "$SERVICE" --now
    if [ $? -ne 0 ]; then
      echo "❌ Failed to start $SERVICE"
      ALERT=true
      MAIL_BODY+="Service $SERVICE failed to start\n-----------------------------------\n"
    else
      echo "✅ $SERVICE is running"
    fi
  fi

  # Check port if provided
  if [ -n "$PORT" ] && [ -n "$SERVICE" ]; then
    echo "Checking port $PORT for $SERVICE..."
    if netstat -lntp | grep -q ":$PORT"; then
      echo "✅ Port $PORT is listening"
    else
      echo "❌ Port $PORT is NOT listening"
      ALERT=true
      MAIL_BODY+="Service $SERVICE: Port $PORT not listening\n-----------------------------------\n"
    fi
  fi
done

# Send consolidated email alert if any failure
if [ "$ALERT" = true ]; then
  echo -e "$MAIL_BODY" | mail -s "🚨 Service/Port Alert on $HOST" "$EMAIL"
fi
