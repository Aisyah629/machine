proc process_data {data_list} {
    set result ""
    foreach item $data_list {
        # Process each item (example: double the number or capitalize string)
        if {[string is integer $item]} {
            append result "$item "
        } else {
            set upper_item [string toupper $item]
            append result "$upper_item "
        }
    }
    return $result
}

puts "Data Processing Tool Loaded"
