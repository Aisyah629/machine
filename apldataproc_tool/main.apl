⍝ ─────────────────────────────────────────────────────────────────────────────
⍝ AplDataProc Tool - Data Processing Utility in APL
⍝ ─────────────────────────────────────────────────────────────────────────────
⍝ This script provides core data manipulation functions including filtering,
⍝ mapping, reducing, and statistical analysis.

⍝ ─────────────────────────────────────────────────────────────────────────────
⍝ Configuration & Constants
⍝ ─────────────────────────────────────────────────────────────────────────────
⎕IO ← 0  ⍝ Origin Index: 0-based

⍝ ─────────────────────────────────────────────────────────────────────────────
⍝ Utility Functions
⍝ ─────────────────────────────────────────────────────────────────────────────

⍝ Filter elements based on a boolean condition array
⍝ Usage: Filter array condition
Filter ← {∧/¨⍵/⍺}

⍝ Map a function over an array
⍝ Usage: {function} map_array
Map ← {
  ¨⍺⍵
}

⍝ Reduce an array with a function
⍝ Usage: {function} reduce_array
Reduce ← {∧/¨⍺⍵}

⍝ Statistical mean
⍝ Usage: Mean array
Mean ← {+/⍵÷⍴⍵}

⍝ Statistical standard deviation
⍝ Usage: StdDev array
StdDev ← {
  m ← Mean ⍵
  ⎕← ((+/((⍵-m)*2))÷(⍴⍵)-1)*0.5
}

⍝ ─────────────────────────────────────────────────────────────────────────────
⍝ Data Processing Pipeline
⍝ ─────────────────────────────────────────────────────────────────────────────

⍝ Main execution block
APL_DATAPROC ← {
  ⍝ Sample data generation
  sample_data ← 100?1000
  
  ⍝ Filter even numbers
  even_numbers ← 2=sample_data|2
  filtered_data ← even_numbers/ sample_data
  
  ⍝ Calculate mean of filtered data
  result_mean ← Mean filtered_data
  
  ⍝ Calculate standard deviation
  result_stddev ← StdDev filtered_data
  
  ⍝ Output results
  ⎕← 'Filtered Count:',⍕⍴filtered_data
  ⎕← 'Mean:',⍕result_mean
  ⎕← 'Std Dev:',⍕result_stddev
  
  ⍝ Return filtered data for further processing
  ⎕← 'Data Processing Complete'
  filtered_data
}

⍝ Execute main pipeline
APL_DATAPROC
