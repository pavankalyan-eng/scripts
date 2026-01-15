#!/bin/bash

# ===== CONFIG =====
EMAIL="pavan667204@gmail.com"
HOST=$(hostname)
TIME=$(date)

# ===== VALIDATE ARGUMENTS =====
if [ $# -lt 1 ]; then
  echo "Usage: $0 <service1:port1> <service2:port2> ..."
  echo "Example: ./multi_service_monitor.sh nginx:80 mysql:3306 docker:2375"
  exit 1
fi

ALERT=false
MAIL_BODY="Service Alert on $HOST at $TIME\n\n"

# ===== LOOP THROUGH SERVICES =====
for ITEM in "$@"; do
  SERVICE=$(echo "$ITEM" | cut -d':' -f1)
  PORT=$(echo "$ITEM" | cut -d':' -f2)

  echo "------------------------------------"
  echo "Checking service: $SERVICE (Port: $PORT)"

  if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ $SERVICE is running"

    # Check port only if port is provided
    if [ -n "$PORT" ]; then
      if ss -tulnp | grep -q ":$PORT"; then
        echo "✅ Port $PORT is listening"
      else
        echo "❌ Port $PORT is NOT listening"
        ALERT=true
        MAIL_BODY+="Service: $SERVICE\nStatus : RUNNING but Port $PORT not listening\n"
        MAIL_BODY+="------------------------------------\n"
      fi
    fi

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

# ===== SEND EMAIL IF ANY ALERT =====
if [ "$ALERT" = true ]; then
  echo -e "$MAIL_BODY" | mail -s "🚨 Service/Port Alert on $HOST" "$EMAIL"
fi
