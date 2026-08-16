#!/bin/bash

# =============================================================================
# Bash System Tool
# =============================================================================
# A comprehensive system health monitoring and cleanup utility written in Bash.
# This script monitors CPU, memory, and disk usage, and performs safe cleanup
# of temporary files, package caches, and old logs.
# =============================================================================

set -euo pipefail

# --- Configuration ---
LOG_DIR="/var/log"
CACHE_DIRS=("/var/cache/apt" "/var/cache/pacman" "/var/cache/yay" "/var/cache/pikaur") # Example distros
TEMP_DIRS=("/tmp" "/var/tmp")
MAX_LOG_AGE_DAYS=30
DRY_RUN=false
REPORT_FILE="/tmp/system_report_$(date +%Y%m%d_%H%M%S).txt"

# --- Color Codes ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Logging ---
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_report() {
    echo "$1" >> "$REPORT_FILE"
}

# --- Helpers ---
get_current_user() {
    echo "$(whoami)"
}

requires_root() {
    if [ "$(id -u)" -ne 0 ]; then
        log_warn "Running as non-root user. Some cleanup operations may require elevated privileges."
        return 1
    fi
    return 0
}

# --- Health Monitoring ---
check_cpu_usage() {
    local load_avg
    load_avg=$(uptime | awk -F'load average: ' '{print $2}' | sed 's/,/ /g' | awk '{print $1}')
    local cpu_count
    cpu_count=$(nproc)
    
    log_report "CPU Load Average: $load_avg (Cores: $cpu_count)"
    
    if (( $(echo "$load_avg > $cpu_count" | bc -l) )); then
        log_warn "CPU load average ($load_avg) exceeds core count ($cpu_count)."
    else
        log_info "CPU load average ($load_avg) is within normal limits."
    fi
}

check_memory_usage() {
    local mem_info
    mem_info=$(free -m | grep Mem)
    local total
    local used
    local percent
    total=$(echo "$mem_info" | awk '{print $2}')
    used=$(echo "$mem_info" | awk '{print $3}')
    percent=$(echo "scale=2; $used/$total*100" | bc)
    
    log_report "Memory Usage: ${used}MB / ${total}MB (${percent}%)"
    
    if (( $(echo "$percent > 90" | bc -l) )); then
        log_warn "Memory usage is critical (${percent}%)."
    else
        log_info "Memory usage is normal (${percent}%)."
    fi
}

check_disk_usage() {
    local disk_usage
    disk_usage=$(df -h / | grep / | awk '{print $5}' | sed 's/%//g')
    
    log_report "Disk Usage (Root): ${disk_usage}%"
    
    if [ "$disk_usage" -gt 90 ]; then
        log_warn "Disk usage is critical (${disk_usage}%)."
    elif [ "$disk_usage" -gt 80 ]; then
        log_info "Disk usage is high (${disk_usage}%). Cleanup recommended."
    else
        log_info "Disk usage is healthy (${disk_usage}%)."
    fi
}

run_health_checks() {
    log_info "Starting System Health Checks..."
    check_cpu_usage
    check_memory_usage
    check_disk_usage
    log_info "Health checks completed."
}

# --- Cleanup Routines ---
cleanup_temp_files() {
    log_info "Cleaning temporary files..."
    for dir in "${TEMP_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            log_info "Scanning $dir for files older than $MAX_LOG_AGE_DAYS days..."
            local count
            count=$(find "$dir" -type f -mtime +"$MAX_LOG_AGE_DAYS" 2>/dev/null | wc -l)
            log_info "Found $count temporary files older than $MAX_LOG_AGE_DAYS days."
            
            if [ "$count" -gt 0 ]; then
                if [ "$DRY_RUN" = true ]; then
                    log_info "[DRY-RUN] Would remove $count files in $dir."
                else
                    find "$dir" -type f -mtime +"$MAX_LOG_AGE_DAYS" -exec rm -f {} \; 2>/dev/null
                    log_info "Removed $count temporary files in $dir."
                fi
            fi
        fi
    done
}

cleanup_package_caches() {
    log_info "Cleaning package manager caches..."
    if ! requires_root; then
        log_warn "Skipping package cache cleanup (requires root)."
        return 1
    fi
    
    for cache in "${CACHE_DIRS[@]}"; do
        if [ -d "$cache" ]; then
            log_info "Clearing cache in $cache..."
            if [ "$DRY_RUN" = true ]; then
                log_info "[DRY-RUN] Would clear $cache."
            else
                # Specific commands for different package managers can be added here
                if [ -d "/var/cache/apt" ] && [ -x "$(command -v apt-get)" ]; then
                    apt-get clean 2>/dev/null
                fi
                # Generic fallback: remove contents
                if [ "$DRY_RUN" = false ]; then
                    rm -rf "$cache"/* 2>/dev/null
                fi
                log_info "Cache in $cache cleared."
            fi
        fi
    done
}

cleanup_old_logs() {
    log_info "Cleaning old log files..."
    if [ ! -d "$LOG_DIR" ]; then
        log_warn "Log directory $LOG_DIR not found. Skipping."
        return 1
    fi
    
    local log_count
    log_count=$(find "$LOG_DIR" -type f -name "*.log" -mtime +"$MAX_LOG_AGE_DAYS" 2>/dev/null | wc -l)
    log_info "Found $log_count log files older than $MAX_LOG_AGE_DAYS days."
    
    if [ "$log_count" -gt 0 ]; then
        if [ "$DRY_RUN" = true ]; then
            log_info "[DRY-RUN] Would remove $log_count old log files."
        else
            find "$LOG_DIR" -type f -name "*.log" -mtime +"$MAX_LOG_AGE_DAYS" -exec rm -f {} \; 2>/dev/null
            log_info "Removed $log_count old log files."
        fi
    fi
}

run_cleanup() {
    log_info "Starting System Cleanup..."
    cleanup_temp_files
    cleanup_package_caches
    cleanup_old_logs
    log_info "Cleanup completed."
}

# --- Main Execution ---
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --health       Run system health checks only"
    echo "  --cleanup      Perform system cleanup routines only"
    echo "  --report       Generate a detailed text report to $REPORT_FILE"
    echo "  --dry-run      Simulate cleanup actions without deleting anything"
    echo "  --help         Display this help message"
}

main() {
    local action="all"
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --health)
                action="health"
                shift
                ;;
            --cleanup)
                action="cleanup"
                shift
                ;;
            --report)
                action="report"
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                log_info "Dry-run mode enabled. No files will be deleted."
                shift
                ;;
            --help)
                usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Initialize report file
    if [ "$action" = "report" ]; then
        echo "System Report - $(date)" > "$REPORT_FILE"
        echo "========================" >> "$REPORT_FILE"
    fi
    
    case "$action" in
        health)
            run_health_checks
            ;;
        cleanup)
            run_cleanup
            ;;
        report)
            run_health_checks
            run_cleanup
            log_info "Report saved to $REPORT_FILE"
            cat "$REPORT_FILE"
            ;;
        all)
            run_health_checks
            run_cleanup
            ;;
    esac
    
    if [ "$action" = "report" ]; then
        rm -f "$REPORT_FILE"
    fi
}

main "$@"
