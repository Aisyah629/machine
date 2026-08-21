-- Euphoria Data Extraction/Parsing Utility
-- Extracts structured data from text files or strings

include std/filesys.e
include std/text.e
include std/io.e

-- Define a simple structure for parsed records
sequence parsed_records = {}

-- Function to read entire file content
private function read_file(file_name)
    integer fh
    string content
    
    fh = open(file_name, "r")
    if fh = 0 then
        printf(1, "Error: Could not open file %s\\n", {file_name})
        return ""
    end if
    
    content = read(fh)
    close(fh)
    return content
end function

-- Function to parse delimited text into records
-- delimiter: string to split by (e.g., ",", "\\t")
public sequence parse_delimited(string input, string delimiter)
    sequence lines, fields, record
    integer delim_len, i, j
    
    delim_len = length(delimiter)
    lines = split(input, "\\n")
    parsed_records = {}
    
    for i = 1 to length(lines) do
        fields = split(lines[i], delimiter)
        record = {}
        for j = 1 to length(fields) do
            -- Trim whitespace
            record &= {trim(fields[j])}
        end for
        if length(record) > 0 then
            parsed_records &= {record}
        end if
    end for
    
    return parsed_records
end function

-- Function to extract specific field from parsed records
-- field_index: 1-based index of the field to extract
public sequence extract_field(sequence records, integer field_index)
    sequence result = {}
    integer i
    
    for i = 1 to length(records) do
        if length(records[i]) >= field_index then
            result &= {records[i][field_index]}
        end if
    end for
    
    return result
end function

-- Main execution
if command_line() = "" then
    puts(1, "Usage: euphoria_data_extractor <input_file> [delimiter]\n")
    puts(1, "Example: euphoria_data_extractor data.csv \",\"\n")
else
    sequence args
    integer fh_out
    string input_file, delimiter
    
    args = command_line()
    input_file = args[1]
    
    if length(args) > 1 then
        delimiter = args[2]
    else
        delimiter = ","
    end if
    
    if not file_exists(input_file) then
        printf(1, "Error: File %s not found.\\n", {input_file})
        abort(1)
    end if
    
    string content = read_file(input_file)
    if length(content) = 0 then
        puts(1, "Error: Empty file or read error.\\n")
        abort(1)
    end if
    
    sequence records = parse_delimited(content, delimiter)
    
    if length(records) = 0 then
        puts(1, "No records found.\\n")
        abort(1)
    end if
    
    -- Output parsed records
    for i = 1 to length(records) do
        for j = 1 to length(records[i]) do
            printf(1, "%s", {records[i][j]})
            if j < length(records[i]) then
                printf(1, "%s", {delimiter})
            end if
        end for
        puts(1, "\\n")
    end for
    
    puts(1, "Total records parsed: " & integer_to_string(length(records)) & "\\n")
end if
