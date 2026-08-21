#!/bin/ksh
#
# ksh_data_processor_tool
# A lightweight, POSIX-compliant data processing utility written in ksh.
#
# Usage: main.ksh [OPTIONS] <input_file>
#

set -o errexit
set -o pipefail

# --- Configuration & Defaults ---
VERSION="1.0.0"
VERBOSE=false
DELIMITER=" "
SELECT_FIELDS=""
INPUT_FILE=""

# --- Functions ---

# Print usage/help information
usage() {
    print -u2 "Usage: ${0} [OPTIONS] <input_file>"
    print -u2 ""
    print -u2 "Options:"
    print -u2 "  -f <fields>  Comma-separated list of 1-based field indices (e.g., 1,3,5)"
    print -u2 "  -d <delimiter>  Set input/output delimiter (default: space)"
    print -u2 "  -v             Enable verbose logging to stderr"
    print -u2 "  -h             Show this help message"
    print -u2 "  --version      Show version"
    exit 1
}

# Log message to stderr if verbose mode is enabled
log_msg() {
    if [[ "$VERBOSE" == true ]]; then
        print -u2 "[INFO] $1"
    fi
}

# Process a single line of input
process_line() {
    local line="$1"
    
    # Handle empty lines
    if [[ -z "$line" ]]; then
        print ""
        return
    fi

    # If no specific fields are selected, output the line as-is with current delimiter
    if [[ -z "$SELECT_FIELDS" ]]; then
        # Re-format the line using the new delimiter
        # We replace multiple delimiters with the new one
        local formatted_line
        formatted_line=$(echo "$line" | sed "s/${DELIMITER}/${DELIMITER}g")
        # Simple approach: read fields into an array if delimiter is simple, else just pass through
        # For robustness with common delimiters like tab or comma, we use awk-like logic in pure ksh
        # But since we want to keep it ksh-native where possible, let's use array splitting
        
        # Note: Standard ksh parameter expansion for splitting uses $IFS
        local OLD_IFS="$IFS"
        IFS="$DELIMITER"
        local -a fields=($line)
        IFS="$OLD_IFS"
        
        # Join with new delimiter (if it's the same, just print fields separated by space
        # If different, we need to be careful with escaping, but for this tool, direct print is fine)
        local output=""
        for field in ${fields[@]}; do
            if [[ -z "$output" ]]; then
                output="$field"
            else
                output="${output}${DELIMITER}${field}"
            fi
        done
        print "$output"
    else
        # Split line into fields based on delimiter
        local OLD_IFS="$IFS"
        IFS="$DELIMITER"
        local -a fields=($line)
        IFS="$OLD_IFS"

        # Select and format fields
        local output=""
        local first=true
        local IFS_OLD=""
        # Set IFS back to empty to preserve fields
        IFS=""
        
        # Parse comma-separated field indices
        local -a indices=(${(s:,:)SELECT_FIELDS})
        
        for idx in $indices; do
            # Validate index is a number and within bounds
            if [[ $idx -ge 1 && $idx -le ${#fields[@]} ]]; then
                local field_value="${fields[$((idx-1))]}"
                if [[ "$first" == true ]]; then
                    output="$field_value"
                    first=false
                else
                    output="${output}${DELIMITER}${field_value}"
                fi
            else
                log_msg "Warning: Field index $idx out of range for line: $line"
            fi
        done
        print "$output"
    fi
}

# --- Main Logic ---

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -f)
            if [[ -n "$2" ]]; then
                SELECT_FIELDS="$2"
                shift 2
            else
                print -u2 "Error: -f requires an argument"
                usage
            fi
            ;;
        -d)
            if [[ -n "$2" ]]; then
                DELIMITER="$2"
                shift 2
            else
                print -u2 "Error: -d requires an argument"
                usage
            fi
            ;;
        -v)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        --version)
            print "ksh_data_processor_tool version $VERSION"
            exit 0
            ;;
        -*)
            print -u2 "Error: Unknown option $1"
            usage
            ;;
        *)
            INPUT_FILE="$1"
            shift
            ;;
    esac
done

# Validate input file
if [[ -z "$INPUT_FILE" ]]; then
    print -u2 "Error: No input file specified."
    usage
fi

if [[ ! -f "$INPUT_FILE" ]]; then
    print -u2 "Error: File not found: $INPUT_FILE"
    exit 1
fi

log_msg "Starting data processing..."
log_msg "Input File: $INPUT_FILE"
log_msg "Delimiter: '$DELIMITER'"
log_msg "Fields to select: ${SELECT_FIELDS:-ALL}"
log_msg "Verbose Mode: $VERBOSE"

# Process file line by line
while IFS= read -r line || [[ -n "$line" ]]; do
    process_line "$line"
done < "$INPUT_FILE"

log_msg "Processing complete."
