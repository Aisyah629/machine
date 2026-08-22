#define VERBOSE 1

/* 
  MOO Data Processor Tool
  A dedicated utility for processing and transforming data.
  Built strictly in MOO.
*/

private list process_data(list input_data)
{
  list output = {};
  integer i;
  string item;
  integer length;

  length = length(input_data);
  for (i = 1; i <= length; i++)
  {
    item = input_data[i];
    if (typeof(item) == TYPE_STRING)
    {
      // Clean whitespace and uppercase the string
      item = lcase(item);
      item = trim(item);
      item = upper(item);
      output = append(output, item);
    }
  }
  return output;
}

public main(args)
{
  list raw_data = {" hello ", "world", " MOO ", "data", " processing ", 123};
  list processed;

  output("Starting MOO Data Processor...\n");
  output("Raw Input: " + raw_data + "\n");

  processed = process_data(raw_data);

  output("Processed Output: " + processed + "\n");
  output("Processing complete.\n");

  return processed;
}

/* Initialize on load */
if (this:main({}) == null)
{
  this:main({});
}

return 0;
