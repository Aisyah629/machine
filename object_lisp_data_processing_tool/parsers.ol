;; parsers.ol - Object Lisp Data Processing Tool Parsers

(in-package #:object-lisp-data-processing)

;; Parse CSV data from a stream
(defun parse-csv (stream)
  (let ((rows '()))
    (loop for line = (read-line stream nil nil)
          while line
          do (push (parse-csv-line line) rows))
    (nreverse rows)))

;; Parse a single CSV line into a data row
(defun parse-csv-line (line)
  (let ((delimiter (slot-value *current-config* 'delimiter)))
    (let ((values (split-string line delimiter)))
      (make-instance 'data-row :values values))))

;; Split a string by a delimiter
(defun split-string (string delimiter)
  (let ((result '()))
    (loop for start = 0 then (1+ pos)
          for pos = (search delimiter string :start2 start)
          while pos
          do (push (subseq string start pos) result))
    (push (subseq string start) result)
    (nreverse result)))
