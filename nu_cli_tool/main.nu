#!/usr/bin/env nu

# Nu CLI Tool - Main Entry Point

# Parse command line arguments
let args = ($nu.args)

if ($args | is-empty) {
    echo "Nu CLI Tool v1.0.0"
    echo "Usage: nu_cli_tool <command> [options]"
    echo ""
    echo "Commands:"
    echo "  eval    Evaluate a Nu expression"
    echo "  run     Run a Nu script"
    exit
}

let command = $args.0

match $command {
    "eval" => {
        if ($args | length) < 2 {
            echo "Error: Missing expression to evaluate"
            exit 1
        }
        let expression = ($args | skip 1 | str join " ")
        try {
            let result = do { $expression }
            echo $result
        } catch {
            echo "Error evaluating expression: $nu.err"
            exit 1
        }
    }
    "run" => {
        if ($args | length) < 2 {
            echo "Error: Missing script path"
            exit 1
        }
        let script_path = $args.1
        if not ($script_path | path exists) {
            echo "Error: Script not found: $script_path"
            exit 1
        }
        try {
            source $script_path
        } catch {
            echo "Error running script: $nu.err"
            exit 1
        }
    }
    _ => {
        echo "Error: Unknown command '$command'"
        echo "Valid commands: eval, run"
        exit 1
    }
}

# Keep the script running if needed (optional)
# loop {
#     wait
# }
