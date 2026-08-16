# TACPOL Standard Library
# Pre-defined global constraints

package require Tcl 8.6

# all_different: All variables in the list must have different values
proc define_global_constraint {name type args} {
    global CONSTRAINT_STORE
    set data [dict create "name" $name "type" $type "args" $args]
    set CONSTRAINT_STORE($name) $data
}

# Initialize standard constraints
define_global_constraint "all_diff_1" "all_diff" {x y z}
define_global_constraint "eq_1" "eq" {a b}
define_global_constraint "neq_1" "neq" {c d}

# Arithmetic constraints
proc define_arithmetic_constraint {name type vars} {
    global CONSTRAINT_STORE
    set data [dict create "name" $name "type" $type "vars" $vars]
    set CONSTRAINT_STORE($name) $data
}

# Cumulative constraint: For scheduling tasks with resource limits
proc define_cumulative_constraint {name type resources tasks limits} {
    global CONSTRAINT_STORE
    set data [dict create "name" $name "type" $type "resources" $resources "tasks" $tasks "limits" $limits]
    set CONSTRAINT_STORE($name) $data
}

# Table constraint: Enforce variable values to be in a specific table of tuples
proc define_table_constraint {name type tuples} {
    global CONSTRAINT_STORE
    set data [dict create "name" $name "type" $type "tuples" $tuples]
    set CONSTRAINT_STORE($name) $data
}

# Element constraint: Element[Idx] = Value
proc define_element_constraint {name type idx var value} {
    global CONSTRAINT_STORE
    set data [dict create "name" $name "type" $type "idx" $idx "var" $var "value" $value]
    set CONSTRAINT_STORE($name) $data
}

# Pre-define common sets of constraints for quick access
set GLOBAL_CONSTRAINTS {
    "all_diff_1" "eq_1" "neq_1"
}
