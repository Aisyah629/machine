-- Main SenseTalk Script for Data Processing Utility
-- File: main.st

-- Global variables for configuration
global gDelimiter, gLogFile, gVerbose

-- Initialization procedure
on init pDelimiter, pLogFile, pVerbose
    put pDelimiter into gDelimiter
    put pLogFile into gLogFile
    put pVerbose into gVerbose
    if gDelimiter is empty then put "," into gDelimiter
    if gLogFile is empty then put "processing.log" into gLogFile
    if gVerbose is empty then put false into gVerbose
    logMessage "Initialization complete."
end init

-- Logging utility
on logMessage pMessage
    if gVerbose then
        put timestamp() & " - " & pMessage & return after file gLogFile
        display pMessage
    else
        put timestamp() & " - " & pMessage & return after file gLogFile
    end if
end logMessage

-- Timestamp utility
function timestamp
    put the date & " " & the time into tTimestamp
    return tTimestamp
end timestamp

-- Extract data from a text file or variable
function myExtractData pData
    -- pData can be a file path or a string
    if isFile(pData) then
        read pData into tContent
    else
        put pData into tContent
    end if
    
    -- Split into lines
    split tContent by CRLF
    put it into tLines
    
    -- Assume first line is header
    put line 1 of tLines into tHeader
    split tHeader by gDelimiter
    put it into tHeaders
    
    -- Initialize data structure
    repeat with i = 2 to the number of lines of tLines
        if line i of tLines is not empty then
            split line i of tLines by gDelimiter
            put it into tValues
            put the number of items of tHeaders into tNumHeaders
            put the number of items of tValues into tNumValues
            if tNumHeaders is tNumValues then
                repeat with j = 1 to tNumHeaders
                    put item j of tValues into field j of line i-1 of tData
                end repeat
                put line i-1 of tLines into line i-1 of tData
            else
                logMessage "Warning: Line " & i & " has mismatched fields."
            end if
        end if
    end repeat
    
    put tHeaders into tHeaderFields
    return {data: tLines, headers: tHeaderFields}
end myExtractData

-- Transform data (e.g., trim, uppercase, etc.)
function myTransformData pData
    repeat with i = 1 to the number of lines of pData
        repeat with j = 1 to the number of fields of line i of pData
            put trim(item j of line i of pData) into item j of line i of pData
        end repeat
    end repeat
    return pData
end myTransformData

-- Validate data (basic type checking)
function myValidateData pData
    repeat with i = 1 to the number of lines of pData
        repeat with j = 1 to the number of fields of line i of pData
            if item j of line i of pData is empty then
                logMessage "Warning: Empty field at line " & i & ", field " & j
                return false
            end if
        end repeat
    end repeat
    return true
end myValidateData

-- Generate a summary report
function myGenerateReport pData
    put "Data Processing Report" into tReport
    put "=====================" & return after tReport
    put "Number of records: " & the number of lines of pData & return after tReport
    put "Number of fields: " & the number of fields of line 1 of pData & return after tReport
    put "File: " & gLogFile & return after tReport
    put "Delimiter: " & gDelimiter & return after tReport
    return tReport
end myGenerateReport

-- Example usage
on run
    init ",", "data_processing.log", true
    
    -- Sample data
    put "Name,Age,City" & CR & "Alice,30,New York" & CR & "Bob,25,Boston" into sampleData
    
    -- Extract
    put myExtractData(sampleData) into rawData
    
    -- Transform
    put myTransformData(rawData.data) into processedData
    
    -- Validate
    if myValidateData(processedData) then
        -- Generate Report
        put myGenerateReport(processedData) into report
        display report
    else
        display "Validation failed."
    end if
end run
