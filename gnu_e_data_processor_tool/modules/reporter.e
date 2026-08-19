IMPLEMENTATION MODULE reporter;

IMPORTS
  system;

PUBLIC DEFINITIONS
  FUNCTION generate(data : List OF Any) : String;

END reporter;

IMPLEMENTATION reporter;

FUNCTION generate(data : List OF Any) : String;
  VAR
    report : String := "Data Processing Report\n";
    count : Integer := length(data);
  BEGIN
    report := report + "Total Records Processed: " + toString(count) + "\n";
    report := report + "Status: COMPLETED\n";
    RETURN report;
  END generate;

END reporter.
