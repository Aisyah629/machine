#!/usr/bin/env python3
"""
Id Tool - Main Execution Script

This script serves as the entry point for the Id programming language tool.
It provides basic parsing and execution capabilities for Id language code.
"""

import sys
import os

# Configuration
TOOL_NAME = "Id Tool"
VERSION = "1.0.0"


def parse_id_code(code: str) -> dict:
    """
    Basic parser for Id language code.
    Returns a dictionary representation of the parsed code structure.
    """
    parsed = {
        "type": "program",
        "statements": []
    }
    lines = code.strip().split('\n')
    for line in lines:
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        # Simple tokenization for demonstration
        tokens = line.split()
        if tokens:
            parsed['statements'].append({
                'type': 'statement',
                'raw': line,
                'tokens': tokens
            })
    return parsed


def execute_parsed(parsed: dict) -> list:
    """
    Executes the parsed Id code structure.
    Returns a list of execution results or errors.
    """
    results = []
    for stmt in parsed.get('statements', []):
        tokens = stmt.get('tokens', [])
        if not tokens:
            continue
        command = tokens[0].lower()
        
        # Mock execution based on command
        if command == 'print':
            if len(tokens) > 1:
                results.append({
                    'type': 'output',
                    'message': ' '.join(tokens[1:])
                })
            else:
                results.append({
                    'type': 'error',
                    'message': 'Missing argument for print command'
                })
        elif command == 'let':
            # Mock variable assignment
            if len(tokens) >= 3 and tokens[1] == '=':
                results.append({
                    'type': 'debug',
                    'message': f"Variable {tokens[0]} assigned to {tokens[2]}"
                })
            else:
                results.append({
                    'type': 'error',
                    'message': 'Invalid let statement syntax'
                })
        else:
            results.append({
                'type': 'warning',
                'message': f"Unknown command: {command}"
            })
    return results


def run_tool(input_file: str = None):
    """
    Main function to run the Id Tool.
    Reads code from file or standard input, parses it, and executes it.
    """
    print(f"Initializing {TOOL_NAME} v{VERSION}...")
    
    code = ""
    if input_file:
        if not os.path.exists(input_file):
            print(f"Error: File '{input_file}' not found.")
            sys.exit(1)
        try:
            with open(input_file, 'r') as f:
                code = f.read()
        except IOError as e:
            print(f"Error reading file: {e}")
            sys.exit(1)
    else:
        print("No input file provided. Entering interactive mode (simulated).")
        code = """# Sample Id Code
print Hello World
let x = 42
print x"""
        print("Using default sample code for demonstration.")

    if not code.strip():
        print("Error: Empty code provided.")
        sys.exit(1)

    print("Parsing code...")
    parsed = parse_id_code(code)
    
    print(f"Parsed {len(parsed['statements'])} statements successfully.")
    print("Executing code...")
    
    results = execute_parsed(parsed)
    
    for res in results:
        if res['type'] == 'output':
            print(res['message'])
        elif res['type'] == 'error':
            print(f"ERROR: {res['message']}")
        elif res['type'] == 'warning':
            print(f"WARNING: {res['message']}")
        elif res['type'] == 'debug':
            print(f"DEBUG: {res['message']}")
            
    print("Execution complete.")


if __name__ == '__main__':
    # Handle command line arguments
    if len(sys.argv) > 1:
        run_tool(sys.argv[1])
    else:
        run_tool()
