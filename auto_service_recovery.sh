#!/bin/bash
# Purpose: Auto-restart services if down
# Author: DevOps
# Usage: sudo ./auto_service_recovery.sh

LOG_FILE="/var/log/auto_service_recovery.log"

# Service : Port
 SERVICES=(
  ["httpd"]=80
  ["mysql"]=3306
  ["ftp"]=21
  ["ssh"]=22
)

log() {
    echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

for service in "${!SERVICES[@]}"; do
    port=${SERVICES[$service]}

    log "Checking service: $service"

    if ! systemctl is-active --quiet "$service"; then
        log "❌ $service is DOWN. Restarting..."
        systemctl restart "$service"

        sleep 2
        if systemctl is-active --quiet "$service"; then
            log "✅ $service restarted successfully"
        else
            log "🚨 FAILED to restart $service"
            continue
        fi
    else
        log "✅ $service is running"
    fi

    if ss -lnt | grep -q ":$port"; then
        log "✅ Port $port is listening"
    else
        log "⚠ Port $port is NOT listening"
    fi

    log "------------------------------------"
done
