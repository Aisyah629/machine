;;==========================================================================
;; lisp_data_processor_tool/main.lsp
;; Description: A comprehensive data processing tool written in AutoLISP.
;; Features: Data extraction, transformation, validation, and formatting.
;;==========================================================================

;;==========================================================================
;; Section 1: Utility Functions
;;==========================================================================

;; Function: safe-extract
;; Description: Safely extracts an element from a list at a given index.
;; Parameters: 
;;   lst - The list to extract from.
;;   idx - The index of the element.
;; Returns: The element at the index, or nil if out of bounds.
(defun safe-extract (lst idx / len val)
  (setq len (length lst))
  (if (and (>= idx 0) (< idx len))
    (nth idx lst)
    (progn
      (princ (strcat "\nWarning: Index " (itoa idx) " out of bounds for list of length " (itoa len) "."))
      nil
    )
  )
)

;; Function: clean-data
;; Description: Removes nil values from a list.
;; Parameters: 
;;   lst - The list to clean.
;; Returns: A new list with nil values removed.
(defun clean-data (lst)
  (vl-remove nil lst)
)

;; Function: flatten-list
;; Description: Recursively flattens a nested list.
;; Parameters: 
;;   lst - The list to flatten.
;; Returns: A flattened list.
(defun flatten-list (lst / result)
  (defun flat-helper (item)
    (if (listp item)
      (foreach sub-item item (flat-helper sub-item))
      (setq result (cons item result))
    )
  )
  (setq result nil)
  (flat-helper lst)
  (reverse result)
)

;;==========================================================================
;; Section 2: Data Extraction Functions
;;==========================================================================

;; Function: extract-by-index
;; Description: Extracts elements from a list by a list of indices.
;; Parameters: 
;;   lst - The source list.
;;   indices - A list of indices to extract.
;; Returns: A list of extracted values.
(defun extract-by-index (lst indices / result)
  (setq result nil)
  (foreach idx indices
    (setq val (safe-extract lst idx))
    (if val (setq result (cons val result)))
  )
  (reverse result)
)

;; Function: extract-by-condition
;; Description: Extracts elements from a list that satisfy a predicate.
;; Parameters: 
;;   lst - The source list.
;;   predicate - A function returning T if the element should be extracted.
;; Returns: A list of elements satisfying the predicate.
(defun extract-by-condition (lst predicate / result)
  (setq result nil)
  (foreach item lst
    (if (apply predicate (list item))
      (setq result (cons item result))
    )
  )
  (reverse result)
)

;;==========================================================================
;; Section 3: Data Transformation Functions
;;==========================================================================

;; Function: transform-data
;; Description: Applies a transformation function to each element in a list.
;; Parameters: 
;;   lst - The source list.
;;   func - A function to apply to each element.
;; Returns: A new list with transformed elements.
(defun transform-data (lst func)
  (mapcar func lst)
)

;; Function: map-data
;; Description: Maps a function over a list, similar to transform-data.
;; Parameters: 
;;   lst - The source list.
;;   func - The function to apply.
;; Returns: A new list with transformed elements.
(defun map-data (lst func)
  (transform-data lst func)
)

;; Function: filter-data
;; Description: Filters a list based on a predicate.
;; Parameters: 
;;   lst - The source list.
;;   predicate - The function to test each element.
;; Returns: A filtered list.
(defun filter-data (lst predicate)
  (extract-by-condition lst predicate)
)

;;==========================================================================
;; Section 4: Data Validation Functions
;;==========================================================================

;; Function: validate-list-type
;; Description: Checks if all elements in a list are of a specific type.
;; Parameters: 
;;   lst - The list to validate.
;;   type-name - The symbol representing the expected type (e.g., 'int, 'str).
;; Returns: T if all elements match the type, nil otherwise.
(defun validate-list-type (lst type-name / is-valid)
  (setq is-valid t)
  (foreach item lst
    (if (not (eq (type item) type-name))
      (setq is-valid nil)
    )
  )
  is-valid
)

;; Function: validate-range
;; Description: Checks if all numbers in a list are within a specified range.
;; Parameters: 
;;   lst - The list of numbers.
;;   min-val - The minimum allowed value.
;;   max-val - The maximum allowed value.
;; Returns: T if all values are within range, nil otherwise.
(defun validate-range (lst min-val max-val / is-valid)
  (setq is-valid t)
  (foreach val lst
    (if (or (< val min-val) (> val max-val))
      (setq is-valid nil)
    )
  )
  is-valid
)

;; Function: validate-non-empty
;; Description: Checks if a list is not empty.
;; Parameters: 
;;   lst - The list to check.
;; Returns: T if not empty, nil otherwise.
(defun validate-non-empty (lst)
  (if (null lst)
    nil
    t
  )
)

;;==========================================================================
;; Section 5: Output Formatting Functions
;;==========================================================================

;; Function: format-as-string
;; Description: Converts a list to a formatted string.
;; Parameters: 
;;   lst - The list to format.
;;   delimiter - A string to separate elements.
;; Returns: A formatted string.
(defun format-as-string (lst delimiter / result)
  (setq result "")
  (foreach item lst
    (if (= result "")
      (setq result (vl-princ-to-string item))
      (setq result (strcat result delimiter (vl-princ-to-string item)))
    )
  )
  result
)

;; Function: print-data
;; Description: Prints data to the command line in a readable format.
;; Parameters: 
;;   data - The data to print.
;;   label - An optional label for the data.
(defun print-data (data label / prefix)
  (if label
    (setq prefix (strcat "\n" label ": "))
    (setq prefix "\nData: ")
  )
  (princ prefix)
  (princ data)
  (princ "\n")
)

;; Function: save-to-file
;; Description: Saves data to a text file.
;; Parameters: 
;;   data - The data to save.
;;   filename - The path to the output file.
;; Returns: T if successful, nil otherwise.
(defun save-to-file (data filename / file-id content)
  (setq file-id (open filename "w"))
  (if file-id
    (progn
      (setq content (format-as-string data " "))
      (write-line content file-id)
      (close file-id)
      (princ (strcat "\nData saved to " filename))
      t
    )
    (progn
      (princ "\nError: Could not open file for writing.")
      nil
    )
  )
)

;;==========================================================================
;; Section 6: Main Entry Point
;;==========================================================================

;; Function: main
;; Description: Demonstrates the usage of the data processing tools.
;; Returns: T to indicate successful execution.
(defun main ()
  (setq sample-data '(1 2 3 4 5 6 7 8 9 10))
  
  ;; Extraction
  (setq extracted (extract-by-index sample-data '(0 2 4)))
  (print-data extracted "Extracted Elements")
  
  ;; Transformation
  (setq transformed (transform-data sample-data '(lambda (x) (* x 2))))
  (print-data transformed "Transformed Data (x2)")
  
  ;; Filtering
  (setq filtered (filter-data sample-data '(lambda (x) (> x 5))))
  (print-data filtered "Filtered Elements (> 5)")
  
  ;; Validation
  (setq is-valid (validate-range sample-data 1 10))
  (princ (strcat "\nData within range [1,10]: " (if is-valid "Yes" "No")))
  
  ;; Formatting
  (setq formatted (format-as-string sample-data ", "))
  (princ (strcat "\nFormatted String: " formatted))
  
  ;; Save to file (example)
  ;; (save-to-file sample-data "C:/temp/lisp_data_output.txt")
  
  (princ "\nData processing completed.")
  t
)

;; Auto-load on startup (optional)
;; (main)
