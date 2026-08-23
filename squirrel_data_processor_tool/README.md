/**
 * Squirrel Data Processor Tool
 * 
 * A utility for transforming, validating, and processing datasets
 * using the Squirrel programming language.
 */

// --- Utility Functions ---

/**
 * Logs a message to the standard output.
 * @param {string} message The message to log.
 * @param {string} level Optional log level (INFO, WARN, ERROR).
 */
function log(message, level = "INFO") {
    local timestamp = "[" + ::clock() + "]";
    ::print(timestamp + " [" + level + "] " + message + "\n");
}

/**
 * Parses a simple CSV-like string into an array of tables.
 * Assumes the first row contains headers.
 * @param {string} csvData The raw CSV string.
 * @return {array} An array of tables representing rows, keyed by headers.
 */
function parseCSV(csvData) {
    local lines = csvData.split("\n");
    if (lines.len() < 2) {
        log("CSV data is empty or has no data rows.", "WARN");
        return [];
    }

    local headers = lines[0].split(",");
    // Trim whitespace from headers
    for (local i = 0; i < headers.len(); i++) {
        headers[i] = headers[i].trim();
    }

    local data = [];
    for (local i = 1; i < lines.len(); i++) {
        local line = lines[i].trim();
        if (line.empty()) continue;

        local values = line.split(",");
        local row = {};
        for (local j = 0; j < headers.len(); j++) {
            row[headers[j]] = values[j].trim();
        }
        data.push(row);
    }
    return data;
}

/**
 * Filters the data based on a simple condition.
 * @param {array} data The dataset to filter.
 * @param {string} column The column name to check.
 * @param {string} operator The operator (eq, neq, gt, lt).
 * @param {string} value The value to compare against.
 * @return {array} The filtered dataset.
 */
function filterData(data, column, operator, value) {
    local filtered = [];
    for (local i = 0; i < data.len(); i++) {
        local row = data[i];
        local rowVal = row[column];
        local matches = false;

        if (operator == "eq") matches = (rowVal == value);
        else if (operator == "neq") matches = (rowVal != value);
        else if (operator == "gt") matches = (::tointeger(rowVal) > ::tointeger(value));
        else if (operator == "lt") matches = (::tointeger(rowVal) < ::tointeger(value));

        if (matches) {
            filtered.push(row);
        }
    }
    log("Filtered data: " + filtered.len() + " records.", "INFO");
    return filtered;
}

/**
 * Converts a dataset back to a CSV string.
 * @param {array} data The dataset to convert.
 * @return {string} The CSV string representation.
 */
function toCSV(data) {
    if (data.len() == 0) return "";

    local headers = data[0].enumkeys();
    local headerStr = headers.join(",") + "\n";
    local rows = [headerStr];

    for (local i = 0; i < data.len(); i++) {
        local line = [];
        for (local j = 0; j < headers.len(); j++) {
            line.push(data[i][headers[j]]);
        }
        rows.push(line.join(",") + "\n");
    }
    return rows.join("");
}

// --- Main Processor Logic ---

function main() {
    log("Squirrel Data Processor Tool initialized.", "INFO");

    // Sample Data
    local sampleCSV = 
"Name, Age, City\n" +
"Alice, 30, New York\n" +
"Bob, 25, San Francisco\n" +
"Charlie, 35, New York\n" +
"David, 28, Boston\n" +
"Eve, 22, San Francisco";

    log("Parsing sample data...", "INFO");
    local data = parseCSV(sampleCSV);
    log("Parsed " + data.len() + " records.", "INFO");

    // Display all data
    log("\n--- Original Data ---\n");
    local output = toCSV(data);
    ::print(output);

    // Example Transformation: Filter by City
    log("\n--- Filtering by City: 'New York' ---\n");
    local filtered = filterData(data, "City", "eq", "New York");
    ::print(toCSV(filtered));

    // Example Transformation: Filter by Age > 25
    log("\n--- Filtering by Age > 25 ---\n");
    local filteredAge = filterData(data, "Age", "gt", "25");
    ::print(toCSV(filteredAge));

    log("\nData processing completed successfully.", "INFO");
}

// Execute
try {
    main();
} catch (e) {
    log("Error: " + e, "ERROR");
}
