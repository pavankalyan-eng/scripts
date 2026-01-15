#!/bin/bash

EMAIL="pavan667204@gmail.com"
HOST=$(hostname)
TIME=$(date)

# Check arguments
if [ $# -lt 1 ]; then
  echo "Usage: $0 <service1> <service2> <service3> ..."
  exit 1
fi

ALERT=false
MAIL_BODY="Service Alert on $HOST at $TIME\n\n"

for SERVICE in "$@"; do
  echo "------------------------------------"
  echo "Checking service: $SERVICE"

  if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ $SERVICE is running"
  else
    echo "❌ $SERVICE is NOT running"
    ALERT=true

    LOGS=$(journalctl -u "$SERVICE" -n 10 --no-pager)

    MAIL_BODY+="Service: $SERVICE\n"
    MAIL_BODY+="Status : NOT RUNNING\n"
    MAIL_BODY+="Last Logs:\n$LOGS\n"
    MAIL_BODY+="------------------------------------\n"
  fi
done

# Send ONE email if any service is down
if [ "$ALERT" = true ]; then
  echo -e "$MAIL_BODY" | mail -s "🚨 Service Down Alert on $HOST" "$EMAIL"
fi
