// T Data Processing Utility
// main.t

import t;
import data;

function process_data(input_data) {
    data = data.load(input_data);
    if (data == null) {
        throw Error("Failed to load data");
    }
    transformed = data.transform();
    validated = data.validate(transformed);
    return validated;
}

function main(args) {
    if (args.length < 1) {
        println("Usage: t main.t <input_file>");
        return;
    }
    input_file = args[0];
    processed_data = process_data(input_file);
    output_path = "processed_output.tdat";
    data.save(processed_data, output_path);
    println("Data processing complete. Output saved to: " + output_path);
}
