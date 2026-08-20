;; classes.ol - Object Lisp Data Processing Tool Class Definitions

(in-package #:object-lisp-data-processing)

;; Base class for data records
defclass record ()
  ((fields :initform nil :accessor fields)
   (metadata :initform nil :accessor metadata)))

;; Class for structured data rows
defclass data-row ()
  ((values :initform nil :accessor values)
   (row-id :initform nil :accessor row-id)))

;; Class for data schemas
defclass schema ()
  ((fields :initform nil :accessor fields)
   (types :initform nil :accessor types)))

;; Class for data transformations
defclass transformation ()
  ((name :initform nil :accessor name)
   (function :initform nil :accessor function)
   (parameters :initform nil :accessor parameters)))

;; Class for configuration settings
defclass config-settings ()
  ((delimiter :initform "," :accessor delimiter)
   (encoding :initform "UTF-8" :accessor encoding)
   (transformations :initform nil :accessor transformations)))
