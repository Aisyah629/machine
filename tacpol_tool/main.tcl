#!/usr/bin/env tclsh
# TACPOL Main Tool
# Version: 1.0.0
# Language: TACPOL

package require Tcl 8.6
package require struct::matrix

# Load core modules
source [file join [file dirname [info script]] "solver_module.tcl"]
source [file join [file dirname [info script]] "library.tcl"]

# Initialize the global constraint store
set CONSTRAINT_STORE [dict create]
set VARIABLES []
set CONSTRAINTS []
set DOMAIN_CACHE [dict create]

# Command line arguments parsing
set OUTPUT_FILE ""
set OPTIMIZATION_MODE 0

foreach arg $::argv {
    switch -- $arg {
        "-o" {
            set OPTIMIZATION_MODE 1
        }
        "-h" {
            puts "Usage: ./main.tcl [options] solution_file.pl"
            puts "Options:"
            puts "  -o          Enable optimization mode"
            puts "  -h          Show this help message"
            puts "Examples:"
            puts "  ./main.tcl puzzle.pl"
            puts "  ./main.tcl -o optimization.pl"
            exit 0
        }
        default {
            set INPUT_FILE $arg
        }
    }
}

if {![info exists INPUT_FILE]} {
    puts "Error: No input file specified."
    puts "Usage: ./main.tcl [options] <file>"
    exit 1
}

if {![file exists $INPUT_FILE]} {
    puts "Error: Input file '$INPUT_FILE' not found."
    exit 1
}

proc load_constraints {file} {
    global CONSTRAINT_STORE VARIABLES CONSTRAINTS DOMAIN_CACHE
    
    # Reset stores
    set CONSTRAINT_STORE [dict create]
    set VARIABLES []
    set CONSTRAINTS []
    set DOMAIN_CACHE [dict create]
    
    set fp [open $file r]
    set content [read $fp]
    close $fp
    
    # Parse the input file
    # Format: var Name Domain [Min Max]
    # Format: constraint Name Type Args...
    set lines [regexp -all -inline {\{[^}]+\}|[^\{]+} $content]
    
    foreach line $lines {
        regsub "^[ ]+" $line "" line
        regsub "[ ]+$" $line "" line
        
        if {"" eq $line} continue
        
        # Determine if it's a variable definition or a constraint
        if {[regexp {^var\s+([a-zA-Z_][a-zA-Z0-9_]*)\s+(\[.+,.*\]|min:(\d+)\s+max:(\d+))} $line match var_name domain_str min_val max_val]} {
            # Process variable definition
            set domains []
            if {[string match "min:*"] $domain_str} {
                # Range definition
                for {set i $min_val} {$i <= $max_val} {incr i} {
                    lappend domains $i
                }
            } else {
                # List definition [a, b, c]
                regsub -all {\[|\]|,} $domain_str " " domain_str
                set domains [split $domain_str]
            }
            set DOMAIN_CACHE($var_name) $domains
            lappend VARIABLES $var_name
            puts "Initialized variable: $var_name with domain size [llength $domains]"
        } elseif {[regexp {^constraint\s+([a-zA-Z_][a-zA-Z0-9_]*)\s+(\w+)} $line match con_name con_type]} {
            # Process constraint
            regsub {^constraint\s+[a-zA-Z_][a-zA-Z0-9_]*\s+\w+\s+} $line "" args_str
            set args [split $args_str " "]
            set constraint_data [dict create "name" $con_name "type" $con_type "args" $args]
            lappend CONSTRAINTS $constraint_data
            set CONSTRAINT_STORE($con_name) $constraint_data
            puts "Loaded constraint: $con_name ($con_type)"
        }
    }
    
    puts "Loaded [llength $VARIABLES] variables and [llength $CONSTRAINTS] constraints."
}

proc solve {optimization} {
    global VARIABLES CONSTRAINTS CONSTRAINT_STORE DOMAIN_CACHE
    
    if {[llength $VARIABLES] == 0} {
        puts "No variables to solve."
        return
    }
    
    puts "Starting solver..."
    puts "Variables: $VARIABLES"
    puts "Constraints: $CONSTRAINTS"
    
    # Simple CSP solver using backtracking with forward checking
    set assignments [dict create]
    set solutions [find_solutions $VARIABLES $CONSTRAINTS $assignments $optimization 0]
    
    puts "\nSolving complete."
    puts "Found [llength $solutions] solution(s)."
    
    foreach sol $solutions {
        puts "Solution: $sol"
        if {$optimization} {
            puts "Optimization Mode: Best value recorded."
        }
    }
}

# Simple solver implementation for demonstration
proc find_solutions {vars constraints assignments optimization depth} {
    global DOMAIN_CACHE CONSTRAINT_STORE
    
    # Base case: all variables assigned
    if {[dict size $assignments] == [llength $vars]} {
        if {$optimization} {
            # In a real solver, we'd calculate an objective function here
            return [list $assignments]
        }
        return [list $assignments]
    }
    
    # Get next unassigned variable
    set current_vars [dict keys $assignments]
    foreach v $vars {
        if {$v ni $current_vars} {
            set var $v
            break
        }
    }
    
    set solutions []
    set domains $DOMAIN_CACHE($var)
    
    # Get applicable constraints
    set relevant_constraints {}
    foreach c $constraints {
        set name [dict get $c "name"]
        set c_args [dict get $c "args"]
        if {$var in $c_args || [lsearch $c_args $var] != -1} {
            lappend relevant_constraints $name
        }
    }
    
    # Try values
    foreach val $domains {
        # Assign value
        set new_assignments [dict set $assignments $var $val]
        
        # Check consistency
        if {[is_consistent $var $val $assignments $constraints]} {
            # Recurse
            set sub_solutions [find_solutions $vars $constraints $new_assignments $optimization [expr $depth + 1]]
            lappend solutions {*}$sub_solutions
            
            if {$optimization} {
                # Optimization logic would go here
                break; # Simplified
            }
        }
    }
    
    return $solutions
}

proc is_consistent {var val assignments constraints} {
    global DOMAIN_CACHE
    
    # Basic consistency check
    # In a real implementation, this would propagate constraints
    # Here we simulate it by checking against pre-defined rules
    
    foreach c $constraints {
        set name [dict get $c "name"]
        set type [dict get $c "type"]
        set args [dict get $c "args"]
        
        # Simple check for equality constraints
        if {$type eq "eq"} {
            set v1 [lindex $args 0]
            set v2 [lindex $args 1]
            if {$v1 in [dict keys $assignments] && $v2 in [dict keys $assignments]} {
                if {[dict get $assignments $v1] != [dict get $assignments $v2]} {
                    return 0
                }
            }
        } elseif {$type eq "neq"} {
            set v1 [lindex $args 0]
            set v2 [lindex $args 1]
            if {$v1 in [dict keys $assignments] && $v2 in [dict keys $assignments]} {
                if {[dict get $assignments $v1] == [dict get $assignments $v2]} {
                    return 0
                }
            }
        } elseif {$type eq "all_diff"} {
            # Check if all variables in args have different values
            set vals {}
            foreach v $args {
                if {$v in [dict keys $assignments]} {
                    lappend vals [dict get $assignments $v]
                }
            }
            set unique_vals [lsort -unique $vals]
            if {[llength $vals] != [llength $unique_vals]} {
                return 0
            }
        }
    }
    return 1
}

# Main execution
load_constraints $INPUT_FILE
solve $OPTIMIZATION_MODE
