/**
 * ARexx Data Processing Utility
 * 
 * This script provides a framework for processing data streams,
 * filtering records, and generating summaries.
 * Designed for the OS/2 ARexx environment.
 */

parse arg datafile action

/* Configuration Constants */
LOG_LEVEL = 3 /* 0: Silent, 1: Errors, 2: Warnings, 3: Info */
DELIMITER = ","
MAX_RECORDS = 10000

/* Main Execution */
signal on halt
signal on error

if datafile = "" | action = "" then do
  say "Usage: data_processing_tool.rexx <datafile> <action>"
  say "Actions: COUNT, FILTER, SORT, SUMMARY"
  exit 255
end

say "Starting Data Processing Tool..."
say "File:" datafile
say "Action:" action

/* Open the data file */
hdl = linein(datafile)
hdl = lineout(datafile)

if hdl = 1 then do
  say "ERROR: Could not open file" datafile
  exit 255
end

/* Process Data based on action */
case action of
when "COUNT" then do
  count = 0
  do while lines(datafile) \= 0
    count = count + 1
  end
  say "Total records:" count
  when "FILTER" then do
  /* Default filter: skip header */
  skip = 1
  do while skip = 1
    line = linein(datafile)
    skip = 0
  end
  do while lines(datafile) \= 0
    line = linein(datafile)
    /* Example: Filter if line contains specific string */
    if pos('ERROR', line) = 0 then
      say line
  end
  when "SUMMARY" then do
  /* Simple statistic generation */
  total_records = 0
  error_records = 0
  do while lines(datafile) \= 0
    line = linein(datafile)
    total_records = total_records + 1
    if pos('ERROR', line) \= 0 then
      error_records = error_records + 1
  end
  say "Processed Records:" total_records
  say "Errors Found:" error_records
  when "SORT" then do
  /* Basic bubble sort simulation for small datasets */
  i = 1
  do while i \= lines(datafile)
    data.i = linein(datafile)
    i = i + 1
  end
  n = i - 1
  do i = 1 to n-1
    do j = 1 to n-i
      if data.j > data.j+1 then do
        temp = data.j
        data.j = data.j+1
        data.j+1 = temp
      end
  end
  do i = 1 to n
    say data.i
  else
    say "Unknown action:" action
    exit 255
end

say "Processing complete."

/* Cleanup */
call lineout datafile, ""
exit 0

error:
  say 'Runtime Error in' sourceline() 'at line' linenum()
  say 'Error Message:' signum()
  exit 255

halt:
  say "User Interrupted."
  exit 0
