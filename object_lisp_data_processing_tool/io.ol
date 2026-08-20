;; io.ol - Object Lisp Data Processing Tool I/O Utilities

(in-package #:object-lisp-data-processing)

;; Read data from a file
(defun read-data (filename)
  (with-open-file (stream filename :direction :input)
    (let ((lines '()))
      (loop for line = (read-line stream nil nil)
            while line
            do (push line lines))
      (nreverse lines))))

;; Write data to a file
(defun write-data (filename data)
  (with-open-file (stream filename :direction :output)
    (loop for item in data
          do (format stream "~A~%" item))))

;; Append data to a file
(defun append-data (filename data)
  (with-open-file (stream filename :direction :output :if-exists :append)
    (loop for item in data
          do (format stream "~A~%" item))))
