;; transformers.ol - Object Lisp Data Processing Tool Transformers

(in-package #:object-lisp-data-processing)

;; Apply transformations to data
(defun transform-data (data transformations)
  (loop for row in data
        collect (apply-transformations row transformations)))

;; Apply a single transformation to a data row
(defun apply-transformations (row transformations)
  (loop for transformation in transformations
        for transformed-row = row then (apply-single-transformation transformed-row transformation)
        finally (return transformed-row)))

;; Apply a single transformation to a data row
(defun apply-single-transformation (row transformation)
  (let ((func (slot-value transformation 'function))
        (params (slot-value transformation 'parameters)))
    (funcall func row params)))

;; Example transformation function: capitalize a field
(defun capitalize-field (row field-name)
  (let ((values (slot-value row 'values)))
    (loop for i from 0 to (1- (length values))
          do (when (string= (aref values i) field-name)
               (setf (aref values i) (string-upcase (aref values i)))))
    row))
