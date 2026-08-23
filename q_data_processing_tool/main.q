\echo Starting Q Data Processing Tool

// Function to process a table of data
processData: {[data; cols]
    / Filter rows where all specified columns are not null
    validData: select from data where all not null/cols!cols
    
    / Calculate summary statistics for numeric columns
    summary: flip (
        "Count"!count each select from validData;
        "Min"!min each select from validData;
        "Max"!max each select from validData;
        "Mean"!mean each select from validData
    );
    
    / Return processed data and summary
    (![data;();0b!();`validData!validData;`summary!summary])
}

// Example usage
// data: ([] date: 2021.01.01 + til 10; value: 100 + til 10; category: `a`b`a`c`a`b`c`a`b`c)
// result: processData[data; (`date; `value; `category)]

\echo Data processing complete
