#!/bin/csh

# =============================================================================
# csh_data_processor_tool
# A utility for data processing written in C Shell (csh).
# =============================================================================

set SCRIPT_NAME = "main.csh"
set SCRIPT_VERSION = "1.0.0"

# Default values
set INPUT_FILE = ""
set OUTPUT_FILE = ""
set FILTER_PATTERN = ""
set GENERATE_STATS = 0
set TRANSFORM_CMD = ""

# =============================================================================
# Usage Function
# =============================================================================
usage () {
    echo "Usage: $SCRIPT_NAME [options]"
    echo ""
    echo "A utility for data processing written in C Shell (csh)."
    echo ""
    echo "Options:"
    echo "  -i, --input <file>        Input file to process (required)"
    echo "  -o, --output <file>       Output file to write results (required)"
    echo "  -f, --filter <pattern>    Filter lines matching the pattern"
    echo "  -t, --transform <cmd>     Transform data using a specified command"
    echo "  -s, --stats               Generate statistical summary"
    echo "  -h, --help                Show this help message"
    echo "  -v, --version             Show version information"
    echo ""
    echo "Examples:"
    echo "  $SCRIPT_NAME -i data.txt -o results.txt -f \"error\""
    echo "  $SCRIPT_NAME -i data.txt -o stats.txt -s"
}

# =============================================================================
# Version Function
# =============================================================================
show_version () {
    echo "$SCRIPT_NAME version $SCRIPT_VERSION"
}

# =============================================================================
# Error Handling
# =============================================================================
error_exit () {
    echo "Error: $1" >&2
    exit 1
}

# =============================================================================
# Logging
# =============================================================================
log_info () {
    echo "[INFO] $1"
}

log_warn () {
    echo "[WARN] $1"
}

log_error () {
    echo "[ERROR] $1" >&2
}

# =============================================================================
# Process Data: Filter
# =============================================================================
process_filter () {
    set input_file = $1
    set output_file = $2
    set pattern = $3

    if ( ! -f "${input_file}" ) then
        error_exit "Input file '${input_file}' not found."
    endif

    if ( ! -f "${output_file}" ) then
        error_exit "Output file '${output_file}' not found."
    endif

    grep "${pattern}" "${input_file}" > "${output_file}"
    
    if ( $status == 0 ) then
        log_info "Filtered lines written to '${output_file}'"
    else
        # grep returns 1 if no lines matched, which is acceptable
        touch "${output_file}"
        log_warn "No lines matched pattern '${pattern}'"
    endif
}

# =============================================================================
# Process Data: Generate Statistics
# =============================================================================
process_stats () {
    set input_file = $1
    set output_file = $2

    if ( ! -f "${input_file}" ) then
        error_exit "Input file '${input_file}' not found."
    endif

    # Initialize variables
    set count = 0
    set sum = 0
    set mean = 0
    set min = 0
    set max = 0

    # Calculate basic statistics using awk
    set stats = `awk '
    BEGIN {
        count = 0;
        sum = 0;
        min = 0;
        max = 0;
    }
    {
        # Try to parse numeric values
        for (i = 1; i <= NF; i++) {
            if ($i ~ /^-?[0-9]+(\.[0-9]+)?$/) {
                count++;
                sum += $i;
                if (count == 1 || $i < min) min = $i;
                if (count == 1 || $i > max) max = $i;
            }
        }
    }
    END {
        if (count > 0) {
            mean = sum / count;
        } else {
            mean = 0;
        }
        printf "%d %.2f %.2f %.2f\n", count, sum, min, max;
    }' "${input_file}"`

    set count = `echo "${stats}" | awk '{print $1}'`
    set sum = `echo "${stats}" | awk '{print $2}'`
    set min = `echo "${stats}" | awk '{print $3}'`
    set max = `echo "${stats}" | awk '{print $4}'`

    # Calculate mean
    if ( ${count} > 0 ) then
        set mean = `awk "BEGIN {printf \"%.2f\", ${sum} / ${count}}"`
    else
        set mean = "0.00"
    endif

    # Write results to output file
    echo "=== Data Statistics ===" > "${output_file}"
    echo "Count: ${count}" >> "${output_file}"
    echo "Sum: ${sum}" >> "${output_file}"
    echo "Mean: ${mean}" >> "${output_file}"
    echo "Min: ${min}" >> "${output_file}"
    echo "Max: ${max}" >> "${output_file}"

    log_info "Statistics written to '${output_file}'"
}

# =============================================================================
# Process Data: Transform
# =============================================================================
process_transform () {
    set input_file = $1
    set output_file = $2
    set transform_cmd = $3

    if ( ! -f "${input_file}" ) then
        error_exit "Input file '${input_file}' not found."
    endif

    # Execute the transformation command
    eval "${transform_cmd}" < "${input_file}" > "${output_file}"
    
    if ( $status == 0 ) then
        log_info "Transformed data written to '${output_file}'"
    else
        error_exit "Transformation failed with command: ${transform_cmd}"
    endif
}

# =============================================================================
# Main Logic
# =============================================================================
main () {
    set args = ( )

    # Parse arguments
    while ( $#argv > 0 ) do
        set arg = $argv[1]
        shift argv

        switch ( "${arg}" ) then
            case "-i":
            case "--input":
                if ( $#argv == 0 ) then
                    error_exit "Option ${arg} requires an argument."
                endif
                set INPUT_FILE = $argv[1]
                shift argv
                break

            case "-o":
            case "--output":
                if ( $#argv == 0 ) then
                    error_exit "Option ${arg} requires an argument."
                endif
                set OUTPUT_FILE = $argv[1]
                shift argv
                break

            case "-f":
            case "--filter":
                if ( $#argv == 0 ) then
                    error_exit "Option ${arg} requires an argument."
                endif
                set FILTER_PATTERN = $argv[1]
                shift argv
                break

            case "-t":
            case "--transform":
                if ( $#argv == 0 ) then
                    error_exit "Option ${arg} requires an argument."
                endif
                set TRANSFORM_CMD = $argv[1]
                shift argv
                break

            case "-s":
            case "--stats":
                set GENERATE_STATS = 1
                break

            case "-h":
            case "--help":
                usage
                exit 0
                break

            case "-v":
            case "--version":
                show_version
                exit 0
                break

            default:
                log_error "Unknown option: ${arg}"
                usage
                exit 1
                break
        endswitch
    end

    # Validate required arguments
    if ( "${INPUT_FILE}" == "" ) then
        log_error "Input file is required."
        usage
        exit 1
    endif

    if ( "${OUTPUT_FILE}" == "" ) then
        log_error "Output file is required."
        usage
        exit 1
    endif

    # Perform processing
    if ( "${FILTER_PATTERN}" != "" ) then
        process_filter "${INPUT_FILE}" "${OUTPUT_FILE}" "${FILTER_PATTERN}"
    else if ( ${GENERATE_STATS} == 1 ) then
        process_stats "${INPUT_FILE}" "${OUTPUT_FILE}"
    else if ( "${TRANSFORM_CMD}" != "" ) then
        process_transform "${INPUT_FILE}" "${OUTPUT_FILE}" "${TRANSFORM_CMD}"
    else
        # Default behavior: copy file
        cp "${INPUT_FILE}" "${OUTPUT_FILE}"
        log_info "File copied to '${OUTPUT_FILE}'"
    endif

    log_info "Processing complete."
}

# Run main
main $argv
