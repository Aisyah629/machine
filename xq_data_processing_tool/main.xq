#!/usr/bin/env xotcl
# main.xq - XOTcl Data Processing Utility

# --- Class Definitions ---

# Base class for data records
oo::class create DataRecord {
    variable data

    constructor(args) {
        next {*}$args
        if {$data eq ""} {
            set data {}
        }
    }

    method setData {jsonString} {
        # Attempt to parse JSON if the string is provided
        # In a real XOTcl environment, json::json2dict might be available
        if {[catch {dict create {*}[json::json2dict $jsonString]} parsedData]} {
            puts "Error: Failed to parse JSON"
            return
        }
        set data $parsedData
    }

    method getData {}
        return $data
    }

    method getKeys {}
        return [dict keys $data]
    }

    method get {key} {
        return [dict get $data $key]
    }
}

# Pipeline class to process records
oo::class create DataPipeline {
    variable records
    variable filters

    constructor {}
        next
        set records {}
        set filters {}
    }

    method addRecord {record} {
        lappend records $record
    }

    method addFilter {script} {
        lappend filters $script
    }

    method execute {}
        set results {}
        foreach rec $records {
            set pass true
            foreach filter $filters {
                # Evaluate the filter script in the context of the current record
                # This is a simplified evaluation; in practice, you'd bind variables
                if {![uplevel 1 $filter]} {
                    set pass false
                    break
                }
            }
            if {$pass} {
                lappend results $rec
            }
        }
        return $results
    }
}

# --- Usage Example ---

# Create a new pipeline
set pipeline [DataPipeline new]

# Create sample data records (using a dict for simplicity as we don't have a real JSON parser in this snippet)
# In a real scenario, you would load these from a file or API
set d1 [DataRecord new]
set d1 data [dict create name "Alice" age 30 city "New York"]
set d2 [DataRecord new]
set d2 data [dict create name "Bob" age 25 city "Boston"]
set d3 [DataRecord new]
set d3 data [dict create name "Charlie" age 35 city "New York"]

# Add records to the pipeline
$pipeline addRecord $d1
$pipeline addRecord $d2
$pipeline addRecord $d3

# Add a filter: only keep records where city is "New York"
$pipeline addFilter {[$rec get city] eq "New York"}

# Execute the pipeline
set filteredData [$pipeline execute]

puts "Filtered Records:"
foreach rec $filteredData {
    puts "Name: [$rec get name], Age: [$rec get age], City: [$rec get city]"
}

# Clean up
$pipeline destroy
$d1 destroy
$d2 destroy
$d3 destroy
