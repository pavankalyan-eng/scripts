#!/bin/bash

SERVICE=$1
EMAIL="pavan667204@gmail.com"

if [ -z "$SERVICE" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi

if ! systemctl is-active --quiet "$SERVICE"; then
  MESSAGE="$SERVICE is NOT running on $(hostname) at $(date)"
  
  echo "$MESSAGE"
  echo "Last logs:"
  LOGS=$(journalctl -u "$SERVICE" -n 20 --no-pager)

  echo "$LOGS"

  # Send email
  {
    echo "$MESSAGE"
    echo
    echo "Last logs:"
    echo "$LOGS"
  } | mail -s "ALERT: $SERVICE DOWN" "$EMAIL"

else
  echo "$SERVICE is running fine"
fi
