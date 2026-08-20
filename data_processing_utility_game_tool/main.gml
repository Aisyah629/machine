/**
 * Data Processing Utility for Game Maker Language
 * Provides basic data manipulation and validation tools.
 */

// Internal state
var __processed_count = 0;

/// @function data_process_utility_init()
/// @description Initializes the internal state of the utility.
/// @returns void
function data_process_utility_init() {
    __processed_count = 0;
}

/// @function validate_data(data, expected_type)
/// @description Validates that the data matches the expected type.
/// @param data Any value to validate.
/// @param expected_type String: 'array', 'struct', 'real', 'string', 'buffer', or 'undefined'.
/// @returns boolean True if valid, false otherwise.
function validate_data(data, expected_type) {
    var actual_type;
    
    if (data == undefined) {
        actual_type = "undefined";
    } else if (is_undefined(data)) {
        actual_type = "undefined";
    } else if (is_array(data)) {
        actual_type = "array";
    } else if (is_struct(data)) {
        actual_type = "struct";
    } else if (is_real(data)) {
        actual_type = "real";
    } else if (is_string(data)) {
        actual_type = "string";
    } else if (is_buffer(data)) {
        actual_type = "buffer";
    } else {
        actual_type = "unknown";
    }
    
    return (actual_type == expected_type);
}

/// @function transform_data(data, operation)
/// @description Applies a transformation operation to the data.
/// @param data The data to transform (array or struct).
/// @param operation String: 'filter_empty', 'sort_asc', 'sort_desc', 'keys_to_struct', 'values_to_array'.
/// @returns any The transformed data.
function transform_data(data, operation) {
    var result;
    
    switch (operation) {
        case "filter_empty":
            if (is_array(data)) {
                result = ds_list_create();
                for (var i = 0; i < array_length(data); i++) {
                    if (data[i] != undefined && data[i] != "" && data[i] != 0) {
                        ds_list_add(result, data[i]);
                    }
                }
                return result;
            }
            break;
            
        case "sort_asc":
            if (is_array(data)) {
                result = ds_list_create();
                for (var i = 0; i < array_length(data); i++) {
                    ds_list_add(result, data[i]);
                }
                ds_list_sort(result, false); // false for ascending
                return result;
            }
            break;
            
        case "sort_desc":
            if (is_array(data)) {
                result = ds_list_create();
                for (var i = 0; i < array_length(data); i++) {
                    ds_list_add(result, data[i]);
                }
                ds_list_sort(result, true); // true for descending
                return result;
            }
            break;
            
        case "keys_to_struct":
            if (is_array(data) && array_length(data) > 0) {
                result = ds_map_create();
                for (var i = 0; i < array_length(data); i++) {
                    ds_map_add(result, string(i), data[i]);
                }
                return result;
            }
            break;
            
        case "values_to_array":
            if (is_struct(data)) {
                var keys = ds_map_find_first(data);
                result = ds_list_create();
                while (keys != "") {
                    ds_list_add(result, data[keys]);
                    keys = ds_map_find_next(data, keys);
                }
                return result;
            }
            break;
    }
    
    return data;
}
