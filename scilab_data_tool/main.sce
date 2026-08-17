// Scilab Data Processing Utility
// This script defines utility functions for data processing

function normalized_data = normalize_data(data)
    // Normalizes the input data to zero mean and unit variance
    mean_val = mean(data);
    std_val = stdev(data);
    if std_val == 0 then
        normalized_data = data - mean_val;
    else
        normalized_data = (data - mean_val) / std_val;
    end
endfunction

function mean_val = compute_mean(data)
    // Computes the mean of the input data
    mean_val = mean(data);
endfunction

function cleaned_data = clean_data(data)
    // Removes NaN and infinite values from the data
    mask = ~isnan(data) & ~isinf(data);
    cleaned_data = data(mask);
endfunction
