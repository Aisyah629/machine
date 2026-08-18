#!/usr/bin/env bash
# =============================================================================
# logging.sh - Logging Utilities
# =============================================================================

log_dir="${SCRIPT_DIR}/logs"
mkdir -p "${log_dir}"
log_file="${log_dir}/system_admin.log"

init_logging() {
    local level="$1"
    CURRENT_LOG_LEVEL="${level}"
    touch "${log_file}"
}

log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $1" >> "${log_file}"
}

log_warn() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [WARN] $1" >> "${log_file}"
}

log_error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1" >> "${log_file}"
}

cleanup_log_files() {
    if [[ -d "${log_dir}" ]]; then
        find "${log_dir}" -name "*.log" -mtime +30 -delete 2>/dev/null || true
    fi
}
