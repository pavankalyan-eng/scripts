#!/bin/bash

# ===== CONFIG =====
EMAIL="pavan667204@gmail.com"
HOST=$(hostname)
TIME=$(date)

# ===== VALIDATION =====
if [ $# -lt 1 ]; then
  echo "Usage: $0 <service1> <service2> <service3> ..."
  exit 1
fi

# ===== LOOP THROUGH ALL SERVICES =====
for SERVICE in "$@"; do
  echo "--------------------------------------"
  echo "Checking service: $SERVICE"

  if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ $SERVICE is running"
  else
    echo "❌ $SERVICE is NOT running"

    # Collect logs
    LOGS=$(journalctl -u "$SERVICE" -n 20 --no-pager)

    MESSAGE="$SERVICE is DOWN on $HOST at $TIME"

    echo "Last logs:"
    echo "$LOGS"

    # ===== EMAIL ALERT =====
    {
      echo "ALERT: Service Down"
      echo
      echo "Service : $SERVICE"
      echo "Host    : $HOST"
      echo "Time    : $TIME"
      echo
      echo "Last logs:"
      echo "$LOGS"
    } | mail -s "🚨 ALERT: $SERVICE DOWN on $HOST" "$EMAIL"

  fi
done
