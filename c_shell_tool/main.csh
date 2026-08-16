#!/bin/csh -f

# C Shell System Administration and Automation Framework
# This script demonstrates core capabilities: process management, resource tracking, and automated backups.

set STATUS = 0

# Function: Log messages with timestamps
# Usage: log_message <level> <message>
proc log_message {
    set level = $1
    shift
    set msg = "$@"
    set timestamp = `date '+%Y-%m-%d %H:%M:%S'`
    echo "[$timestamp] [$level] $msg"
}

# Function: Monitor running processes
# Usage: monitor_processes
proc monitor_processes {
    log_message "INFO" "Monitoring running processes..."
    if ( -x /bin/ps ) then
        ps aux | head -20
    else
        log_message "WARN" "ps command not found or not executable"
    endif
}

# Function: Check system resource usage
# Usage: check_resources
proc check_resources {
    log_message "INFO" "Checking system resources..."
    if ( -x /bin/df ) then
        echo "Disk Usage:"
        df -h
    else
        log_message "WARN" "df command not found"
    endif

    if ( -x /bin/uptime ) then
        echo "System Uptime:"
        uptime
    else
        log_message "WARN" "uptime command not found"
    endif
}

# Function: Create a backup of a specified directory
# Usage: create_backup <source_dir> <backup_dir>
proc create_backup {
    set source = $1
    set dest = $2

    if ( ! -d "$source" ) then
        log_message "ERROR" "Source directory '$source' does not exist"
        return 1
    endif

    log_message "INFO" "Creating backup of '$source' to '$dest'"
    if ( -d "$dest" ) then
        cp -rp "$source"/* "$dest/"
    else
        mkdir -p "$dest"
        cp -rp "$source"/* "$dest/"
    endif
    log_message "INFO" "Backup completed successfully"
    return 0
}

# Function: Manage system alerts
# Usage: send_alert <message>
proc send_alert {
    set alert_msg = "$@"
    log_message "ALERT" "$alert_msg"
    # In a real scenario, this would send an email or notify a service
    # For now, we just log it.
}

# Main Execution Flow
log_message "INFO" "Starting C Shell System Administration Framework"

# Example: Monitor processes
monitor_processes

# Example: Check resources
check_resources

# Example: Create backup (commented out by default for safety)
# create_backup "/etc" "/tmp/backup_etc"

# Example: Send alert
send_alert "System maintenance check complete."

log_message "INFO" "Framework execution finished"
exit $STATUS
