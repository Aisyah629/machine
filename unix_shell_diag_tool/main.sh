#!/bin/bash

# =============================================================================
# Unix Shell System Diagnostic Tool
# Language: Unix Shell (Bash)
# =============================================================================
# Description:
# This tool is a lightweight, POSIX-compliant shell script that performs
# fundamental system diagnostics, including hardware overview, process
# monitoring, disk space analysis, and network interface verification.
#
# It is designed for quick, dependency-free execution on Linux and macOS
# environments.
# =============================================================================

set -euo pipefail

# --- Configuration ---
LOG_FILE="/var/log/system_diag.log"
OUTPUT_DIR="/tmp/system_diag_$(date +%Y%m%d_%H%M%S)"
VERBOSE=0

# --- Functions ---

log_msg() {
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1"
    if [[ "$VERBOSE" -eq 1 ]]; then
        echo "$1"
    fi
}

create_output_dir() {
    if [[ ! -d "$OUTPUT_DIR" ]]; then
        mkdir -p "$OUTPUT_DIR"
        log_msg "Created output directory: $OUTPUT_DIR"
    fi
}

check_hardware_info() {
    log_msg "Collecting hardware information..."
    echo "=== SYSTEM HARDWARE INFO ===" > "$OUTPUT_DIR/hardware.txt"
    
    if command -v lsb_release &> /dev/null; then
        echo "OS: $(lsb_release -ds 2>/dev/null || echo 'N/A')" >> "$OUTPUT_DIR/hardware.txt"
    else
        echo "OS: $(uname -s) $(uname -r)" >> "$OUTPUT_DIR/hardware.txt"
    fi
    
    echo "Hostname: $(hostname)" >> "$OUTPUT_DIR/hardware.txt"
    echo "Architecture: $(uname -m)" >> "$OUTPUT_DIR/hardware.txt"
    echo "CPU Model: $(grep 'model name' /proc/cpuinfo 2>/dev/null | head -n 1 | cut -d: -f2 || echo 'N/A')" >> "$OUTPUT_DIR/hardware.txt"
    echo "CPU Cores: $(nproc 2>/dev/null || echo 'N/A')" >> "$OUTPUT_DIR/hardware.txt"
    
    log_msg "Hardware info saved to $OUTPUT_DIR/hardware.txt"
}

check_disk_usage() {
    log_msg "Analyzing disk space usage..."
    echo "=== DISK USAGE ===" > "$OUTPUT_DIR/disk.txt"
    df -h 2>/dev/null >> "$OUTPUT_DIR/disk.txt" || echo "Disk information unavailable." >> "$OUTPUT_DIR/disk.txt"
    
    # Check for partitions over 90% usage
    local threshold=90
    df -h 2>/dev/null | awk 'NR>1 { print $5 }' | sed 's/%//' | while read -r usage; do
        if [[ "$usage" -gt "$threshold" ]]; then
            log_msg "WARNING: Filesystem usage is at ${usage}%"
        fi
    done
    
    log_msg "Disk usage saved to $OUTPUT_DIR/disk.txt"
}

check_active_processes() {
    log_msg "Listing top active processes..."
    echo "=== TOP PROCESSES BY CPU ===" > "$OUTPUT_DIR/processes.txt"
    ps aux --sort=-%cpu 2>/dev/null | head -n 11 >> "$OUTPUT_DIR/processes.txt" || echo "Process information unavailable." >> "$OUTPUT_DIR/processes.txt"
    
    echo -e "\n=== TOP PROCESSES BY MEMORY ===" >> "$OUTPUT_DIR/processes.txt"
    ps aux --sort=-%mem 2>/dev/null | head -n 11 >> "$OUTPUT_DIR/processes.txt" || echo "Process information unavailable." >> "$OUTPUT_DIR/processes.txt"
    
    log_msg "Process list saved to $OUTPUT_DIR/processes.txt"
}

check_network_interfaces() {
    log_msg "Gathering network interface details..."
    echo "=== NETWORK INTERFACES ===" > "$OUTPUT_DIR/network.txt"
    if command -v ip &> /dev/null; then
        ip addr show 2>/dev/null >> "$OUTPUT_DIR/network.txt"
    elif command -v ifconfig &> /dev/null; then
        ifconfig -a 2>/dev/null >> "$OUTPUT_DIR/network.txt"
    else
        echo "Network information unavailable." >> "$OUTPUT_DIR/network.txt"
    fi
    
    log_msg "Network info saved to $OUTPUT_DIR/network.txt"
}

run_diagnostics() {
    log_msg "Starting system diagnostics..."
    create_output_dir
    check_hardware_info
    check_disk_usage
    check_active_processes
    check_network_interfaces
    log_msg "Diagnostics complete. Results available in: $OUTPUT_DIR"
}

# --- Main Execution ---
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -v     Enable verbose output"
    echo "  -h     Show this help message"
    exit 0
}

while getopts "vh" opt; do
    case $opt in
        v) VERBOSE=1 ;;
        h) usage ;;
        *) echo "Invalid option. Use -h for help."; exit 1 ;;
    esac
done

run_diagnostics
