#!/bin/csh
#
# csh_system_monitoring_tool
# A comprehensive system monitoring utility.
# Tracks CPU and memory utilization, logs system events,
# and triggers alerts when predefined performance thresholds are breached.
#

set SCRIPT_DIR = `dirname \(set 0; echo \$0\)`
set LOG_DIR = "\$SCRIPT_DIR/logs"
set CPU_THRESHOLD = 85
set MEMORY_THRESHOLD = 90
set MAX_LOG_SIZE = 10485760  # 10 MB in bytes
set ALERT_EMAIL = "admin@example.com"

# Create log directory if it doesn't exist
if ( ! -d \$LOG_DIR ) then
    mkdir -p \$LOG_DIR
endif

set LOG_FILE = "\$LOG_DIR/system_monitor.log"

# Function to log messages
# Usage: log_event "message"
# Redirects output to both stdout and log file with timestamp
alias log_event 'echo "\`date \"+%Y-%m-%d %H:%M:%S\`\" | xargs -I {} echo "{} - {}"' >> \$LOG_FILE
cat << 'EOF'
EOF

# Function to log_event
alias log_event 'exec 3>&1; exec >> \$LOG_FILE; echo "\`date "+%Y-%m-%d %H:%M:%S\"\` - \$1"; exec 1>&3- 2>&3-; echo "\$1"'

# Function to rotate logs
# Usage: rotate_logs <log_file> <max_size>
alias rotate_logs 'if ( \$1 != "" ) then
    if ( -f \$1 ) then
        set fsize = `wc -c < \$1`
        if ( \$fsize > \$MAX_LOG_SIZE ) then
            mv \$1 \$1.old
            echo "\`date "+%Y-%m-%d %H:%M:%S\"\` Log rotated: \$1" >> \$1.old
            touch \$1
            log_event "Log rotated: \$1"
        endif
    endif
endif'

# Function to get CPU usage
alias get_cpu_usage 'top -l 1 -n 1 | grep "CPU usage" | sed "s/.*CPU usage: //; s/%.*//"'
# Alternative for systems without top -l support
catch set _cpu = `vm_stat | awk "/Pages inactive/{inactive=\$2} /Pages wired/{wired=\$2} /Pages active/{active=\$2} END{print int((\$inactive+\$wired+\$active)/(inactive+wired+active+free)*100)}"` 
catch set _cpu = `cat /dev/null`
set CPU_USAGE = \? == 0 ? "\$_cpu" : "0"

# Function to get Memory usage
alias get_mem_usage 'vm_stat | awk "/Pages active/{active=\$2} /Pages inactive/{inactive=\$2} /Pages wired/{wired=\$2} /Pages free/{free=\$2} END{printf \\"%.2f\\\\", (active+inactive+wired)/(active+inactive+wired+free)*100}"

# Function to send alert
# Usage: send_alert "subject" "body"
alias send_alert 'echo "\$2" | mail -s "\$1" \$ALERT_EMAIL'

# Main monitoring loop
log_event "System monitoring started."

while ( 1 ) do
    # Get CPU Usage
    set CPU_USAGE = \`top -l 1 -n 1 | grep "CPU usage" | sed "s/.*CPU usage: //; s/%.*//"` 2>/dev/null
    if ( \$? != 0 ) then
        set CPU_USAGE = 0
    endif

    # Get Memory Usage
    set MEM_USAGE = \`vm_stat | awk "/Pages active/{active=\$2} /Pages inactive/{inactive=\$2} /Pages wired/{wired=\$2} /Pages free/{free=\$2} END{printf \\"%.2f\\\\", (active+inactive+wired)/(active+inactive+wired+free)*100}"` 2>/dev/null
    if ( \$? != 0 ) then
        set MEM_USAGE = 0
    endif

    # Log current status
    log_event "CPU Usage: \$CPU_USAGE% | Memory Usage: \$MEM_USAGE%"

    # Check CPU Threshold
    set CPU_INT = `echo \$CPU_USAGE | cut -d. -f1`
    if ( \$CPU_INT > \$CPU_THRESHOLD ) then
        log_event "WARNING: CPU usage \$CPU_USAGE% exceeds threshold \$CPU_THRESHOLD%"
        send_alert "CPU Alert" "CPU usage is at \$CPU_USAGE%. Threshold is \$CPU_THRESHOLD%."
    endif

    # Check Memory Threshold
    set MEM_INT = `echo \$MEM_USAGE | cut -d. -f1`
    if ( \$MEM_INT > \$MEMORY_THRESHOLD ) then
        log_event "WARNING: Memory usage \$MEM_USAGE% exceeds threshold \$MEMORY_THRESHOLD%"
        send_alert "Memory Alert" "Memory usage is at \$MEM_USAGE%. Threshold is \$MEMORY_THRESHOLD%."
    endif

    # Rotate logs if necessary
    rotate_logs \$LOG_FILE

    # Sleep for 5 seconds
    sleep 5
done
EOF
