#!/usr/bin/env bash
# =============================================================================
# monitoring.sh - System Resource Monitoring Functions
# =============================================================================

monitor_resources() {
    local cpu_usage
    local mem_usage
    local disk_usage

    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    mem_usage=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
    disk_usage=$(df / | awk 'NR==2 {print $5}' | cut -d% -f1)

    log_info "Resources - CPU: ${cpu_usage}%, RAM: ${mem_usage}%, Disk: ${disk_usage}%"

    if [[ ${cpu_usage} -gt ${CPU_THRESHOLD:-85} ]]; then
        send_alert "High CPU usage detected: ${cpu_usage}%"
    fi
    if [[ ${mem_usage} -gt ${MEMORY_THRESHOLD:-90} ]]; then
        send_alert "High memory usage detected: ${mem_usage}%"
    fi
    if [[ ${disk_usage} -gt ${DISK_THRESHOLD:-80} ]]; then
        send_alert "High disk usage detected: ${disk_usage}%"
    fi
}

check_service_health() {
    local services=("nginx" "mysql" "redis")
    for svc in "${services[@]}"; do
        if systemctl is-active --quiet "${svc}"; then
            log_info "Service ${svc} is running."
        else
            log_warn "Service ${svc} is down. Attempting restart..."
            systemctl restart "${svc}" 2>/dev/null || log_error "Failed to restart ${svc}"
        fi
    done
}
