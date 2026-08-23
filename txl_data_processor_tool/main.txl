% TXL Script for Data Processing
% This script processes a simple CSV-like format: id,name,value

rule process_file
    "id,name,value"
    replace with
    "{\n  \"data\": ["
end

rule process_line
    int:id "," string:name "," int:value
    replace with
    "{ \"id\": " id ", \"name\": \"" name "\", \"value\": " value " },"
end

rule process_end
    "}"
    replace with
    "{ \"id\": 0, \"name\": \"\", \"value\": 0 }\n  ]\n}"
end

rule process_file_end
    "}"
    replace with
    "{ \"id\": 0, \"name\": \"\", \"value\": 0 }\n  ]\n}"
end

% Main transformation to convert CSV to a custom JSON-like format
main
    rule process_file
    rule process_line
    rule process_end
end
