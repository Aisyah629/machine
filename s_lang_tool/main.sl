/*
 * S-Lang Tool: main.sl
 * 
 * This script demonstrates the core functionality of the S-Lang tool.
 * It includes basic setup, data processing, and output examples.
 */

// Initialize the environment
include "slang.h"
include "dos.h"
include "math.h"

// Define a custom function for data processing
define process_data(input_array)
  variable result_array = copy(input_array);
  variable n = length(result_array);
  
  // Example processing: Normalize the data
  variable max_val = max(result_array);
  if (max_val != 0)
    result_array = result_array / max_val;
  endif
  
  return result_array;
enddefine

// Main execution block
begin
  // Sample input data
  variable data = [10, 20, 30, 40, 50];
  
  // Process the data
  variable processed_data = process_data(data);
  
  // Output the results
  \n"Original Data: ";
  print(data);
  \n"Processed Data: ";
  print(processed_data);
  
  // Demonstrate interactive capability (commented out for automated testing)
  // variable user_input = read_line("Enter a number: ");
  // print("You entered: ", user_input);
  
  \n"S-Lang Tool executed successfully.\n";
end
