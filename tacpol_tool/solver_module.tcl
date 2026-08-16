# TACPOL Solver Module
# Core solver implementation

package require Tcl 8.6

# Solver State
set BACKTRACK_DEPTH 0
set MAX_DEPTH 1000
set SOLUTION_FOUND 0

# Find the best next variable to assign using MRV (Minimum Remaining Values) heuristic
proc select_variable {unassigned_vars domains} {
    set best_var ""
    set min_size 999999
    
    foreach v $unassigned_vars {
        set d [dict get $domains $v]
        if {[llength $d] < $min_size} {
            set min_size [llength $d]
            set best_var $v
        }
    }
    return $best_var
}

# Order values using LCV (Least Constraining Value) heuristic
proc order_values {var val domains neighbors} {
    return $val
}

# Update domains and check for failure
proc revise {x y x_domain y_domain constraint} {
    set revised 0
    foreach v $x_domain {
        if {![satisfies_constraint $v $y_domain $constraint]} {
            lremove x_domain $v
            set revised 1
        }
    }
    return $revised
}

proc satisfies_constraint {v y_domain constraint} {
    # Placeholder for actual constraint satisfaction logic
    return 1
}

# Forward Checking
proc forward_check {var val assignments constraints domains} {
    global CONSTRAINT_STORE
    
    foreach c [get_constraints_for_variable $var] {
        set c_args [dict get $c "args"]
        # Identify neighboring variables
        set neighbors {}
        foreach a $c_args {
            if {$a != $var && $a in [dict keys $domains]} {
                lappend neighbors $a
            }
        }
        
        foreach n $neighbors {
            set new_domain [dict get $domains $n]
            if {[llength [filter_domain $n $val $c]] == 0} {
                return 0
            }
        }
    }
    return 1
}

# Constraint propagation using AC-3
proc ac3 {variables domains} {
    set queue {}
    foreach var $variables {
        foreach c [get_constraints_for_variable $var] {
            lappend queue $var [dict get $c "args"]
        }
    }
    
    while {[llength $queue] > 0} {
        set arc [lindex $queue 0]
        set queue [lrange $queue 1 end]
        
        set x [lindex $arc 0]
        set y [lindex $arc 1]
        
        set revised [revise $x $y [dict get $domains $x] [dict get $domains $y] [dict get $CONSTRAINT_STORE $y]]
        
        if {$revised} {
            if {[llength [dict get $domains $x]] == 0} {
                return 0
            }
            foreach neighbor [get_neighbors $x $y] {
                if {$neighbor != $y} {
                    lappend queue $neighbor $x
                }
            }
        }
    }
    return 1
}

# Helper to get neighbors for a variable
proc get_neighbors {x y} {
    set neighbors {}
    foreach c [dict values $CONSTRAINT_STORE] {
        set args [dict get $c "args"]
        if {$x in $args} {
            foreach a $args {
                if {$a != $x && $a != $y} {
                    lappend neighbors $a
                }
            }
        }
    }
    return $neighbors
}

# Get constraints involving a specific variable
proc get_constraints_for_variable {var} {
    set relevant {}
    foreach c [dict values $CONSTRAINT_STORE] {
        set args [dict get $c "args"]
        if {$var in $args} {
            lappend relevant $c
        }
    }
    return $relevant
}

# Filter domain of a variable based on a constraint
proc filter_domain {var val constraint} {
    set domain [dict get $DOMAIN_CACHE $var]
    set filtered_domain {}
    foreach v $domain {
        # In a full implementation, we check if v and val satisfy the constraint together
        # For now, assume all are valid
        lappend filtered_domain $v
    }
    return $filtered_domain
}

# Remove an element from a list
proc lremove {listname value} {
    upvar 1 $listname lst
    set index [lsearch $lst $value]
    if {$index != -1} {
        set lst [lreplace $lst $index $index]
    }
}
