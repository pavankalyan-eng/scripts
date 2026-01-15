#!/bin/bash
SERVICE="httpd"
PORT=80

if ! systemctl is-active --quiet "$SERVICE"; then
    systemctl restart "$SERVICE"
fi

if ss -lnt | grep -q ":$PORT"; then
    echo "✅ $SERVICE is running and port $PORT is open"
else
    echo "🚨 $SERVICE restarted but port $PORT not listening"
fi
