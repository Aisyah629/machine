#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# bash_system_admin_tool - main.sh
# =============================================================================
# Comprehensive automated server health monitoring and maintenance script.
# Built strictly using bash.
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/monitoring.sh"
source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/alerts.sh"

CONFIG_FILE="${1:-${SCRIPT_DIR}/config.ini}"
LOG_LEVEL="${2:-INFO}"

init_logging "${LOG_LEVEL}"
log_info "System admin tool initialized."
log_info "Configuration loaded from: ${CONFIG_FILE}"

if [[ ! -f "${CONFIG_FILE}" ]]; then
    log_error "Configuration file not found: ${CONFIG_FILE}"
    exit 1
fi

cleanup_log_files
check_service_health
monitor_resources

log_info "Health check cycle completed successfully."
exit 0
