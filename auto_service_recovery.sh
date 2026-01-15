#!/bin/bash
# Purpose: Auto-install, restart, and verify services
# OS: RHEL / CentOS / AlmaLinux
# Run as: root

LOG_FILE="/var/log/auto_service_recovery.log"

# Service : Port : Package
declare -A SERVICES=(
  ["sshd"]="22 openssh-server"
  ["httpd"]="80 httpd"
  ["mysqld"]="3306 mysql-server"
  ["vsftpd"]="21 vsftpd"
)

log() {
    echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

for service in "${!SERVICES[@]}"; do
    port=$(echo "${SERVICES[$service]}" | awk '{print $1}')
    package=$(echo "${SERVICES[$service]}" | awk '{print $2}')

    log "Checking service: $service"

    # 1️⃣ Check if service exists
    if ! systemctl list-unit-files | grep -q "^$service.service"; then
        log "⚠ $service not installed. Installing package: $package"
        dnf install -y "$package" &>>"$LOG_FILE"
    fi

    # 2️⃣ Enable and start service
    if ! systemctl is-active --quiet "$service"; then
        log "❌ $service is DOWN. Restarting..."
        systemctl enable --now "$service" &>>"$LOG_FILE"
        sleep 2
    fi

    # 3️⃣ Verify service status
    if systemctl is-active --quiet "$service"; then
        log "✅ $service is running"
    else
        log "🚨 FAILED to start $service"
        continue
    fi

    # 4️⃣ Verify port
    if ss -lnt | grep -q ":$port"; then
        log "✅ Port $port is listening"
    else
        log "⚠ Port $port is NOT listening"
    fi

    log "------------------------------------"
done
