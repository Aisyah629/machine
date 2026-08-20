// S/SL Data Processing Utility
// This script demonstrates data filtering, transformation, and analysis.

// Function to read data from a file
function read_data(file_path)
    data = []
    open(file_path, "r")
    while not eof()
        line = read_line()
        data = append(data, split(line, ","))
    end
    close()
    return data
end

// Function to filter data based on a condition
function filter_data(data, condition)
    filtered = []
    for each row in data
        if condition(row)
            filtered = append(filtered, row)
        end
    end
    return filtered
end

// Function to analyze data (example: calculate mean of a column)
function analyze_data(data, column_index)
    sum = 0
    count = 0
    for each row in data
        if is_number(row[column_index])
            sum = sum + to_number(row[column_index])
            count = count + 1
        end
    end
    if count > 0
        return sum / count
    else
        return 0
    end
end

// Main execution
main = begin
    input_file = "data.csv"
    output_file = "output.csv"
    
    // Read data
    data = read_data(input_file)
    
    // Filter data (example: filter rows where first column > 10)
    condition = function(row) row[0] > 10 end
    filtered_data = filter_data(data, condition)
    
    // Analyze data (example: mean of second column)
    mean = analyze_data(filtered_data, 1)
    
    // Write output
    open(output_file, "w")
    for each row in filtered_data
        write_line(concat(row, ","))
    end
    close()
    
    print("Analysis complete. Mean: " + mean)
end

// Run main
main()
