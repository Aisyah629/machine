; Arc Data Processing Utility

; Helper: Load a file as a string
(def load-file (fname)
  (read-table (open-in fname)))

; Helper: Parse a simple JSON-like structure (for demonstration)
; Note: Arc does not have built-in JSON in the core, so this is a placeholder
; for a more robust library-based approach in a real scenario.
; We assume a simplified map/list structure.

(def process-data (data)
  "Process a list of records. Each record is a map/dict."
  (if (empty? data)
      '()
      (let (record (car data)
            rest (cdr data))
        (if (is-record? record)
            (cons (transform-record record)
                  (process-data rest))
            (process-data rest)))))

(def is-record? (x)
  "Check if x is a list with at least one key-value pair (simulated)."
  (and (list? x) (>= (length x) 2)))

(def transform-record (record)
  "Transform a single record by adding a 'processed' key."
  (let (key (car record)
        val (cadr record))
    (list key val 'processed 't)))

(def filter-data (data predicate)
  "Filter data based on a predicate function."
  (cond ((empty? data) '())
        ((funcall predicate (car data))
         (cons (car data) (filter-data (cdr data) predicate)))
        (t (filter-data (cdr data) predicate))))

(def main
  "Main execution entry point."
  (print "Arc Data Processing Utility Starting...")
  
  ; Sample data: list of lists simulating records [key value]
  (let sample-data '(('name 'Alice) ('age '30) ('name 'Bob) ('age '25))
    
    (print "Original Data:")
    (print sample-data)
    
    (print "\nTransformed Data:")
    (let transformed (process-data sample-data)
      (print transformed))
      
    (print "\nFiltering for 'Alice':")
    (let filtered (filter-data transformed (fn (r) (is (cadr r) 'Alice)))
      (print filtered))
      
    (print "\nProcessing Complete.")
    ))

; Run main if executed directly
(main)
