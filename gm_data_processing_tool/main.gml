// gm_data_processing_tool/main.gml
// Data Processing Utility in Game Maker Language

// Initialize data buffer
var buffer_size = 1024;
var data_buffer = ds_list_create();

/// @description Process Input Data
/// @param input_data The raw data list or map to process
function process_data(input_data) {
    var result = ds_list_create();
    
    if (ds_list_size(input_data) > 0) {
        for (var i = 0; i < ds_list_size(input_data); i++) {
            var item = ds_list_find_value(input_data, i);
            if (is_string(item)) {
                item = string_upper(item);
            }
            ds_list_add(result, item);
        }
    }
    
    return result;
}

/// @description Clean Data
/// @param data The data list to clean
function clean_data(data) {
    for (var i = ds_list_size(data) - 1; i >= 0; i--) {
        var item = ds_list_find_value(data, i);
        if (item == undefined || item == "") {
            ds_list_delete(data, i);
        }
    }
    return data;
}

/// @description Export Data
/// @param data The data list to export
function export_data(data) {
    var output_string = "";
    for (var i = 0; i < ds_list_size(data); i++) {
        output_string += ds_list_find_value(data, i) + "\n";
    }
    return output_string;
}

// Example Execution
var raw_data = ds_list_create();
ds_list_add(raw_data, "apple");
ds_list_add(raw_data, "banana");
ds_list_add(raw_data, "");
ds_list_add(raw_data, "cherry");

var processed = process_data(raw_data);
var cleaned = clean_data(processed);
var exported = export_data(cleaned);

// Cleanup
ds_list_destroy(raw_data);
ds_list_destroy(processed);
ds_list_destroy(cleaned);
