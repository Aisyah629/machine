; API Client Tool
; This code interacts with REST APIs, handles JSON, and processes data transfers.
; Compatible with Lisp environments for API integrations.

(defun fetch-data (endpoint method)
  (let ((http (make-http-connection))
        (response (make-instance 'http-response)))
    (setf (http-url http) (concatenate 'string "https://api.example.com/v1" endpoint))
    (setf (http-method http) method)
    (setf (http-header http) (list (cons "Authorization" (concatenate 'string "Bearer " api-key))))
    
    (handler-case
        (progn
          (http-send-request http)
          (setf response (http-get-response http))
          (if (not (member (http-status-code response) '(200 201 204)))
              (error "API Error: ~A ~A" (http-status-code response) (http-get-body response)))
          (json-deserialize (http-get-body response)))
      (error (e)
        (error "Exception: ~A" e)))))

(defun send-payload (endpoint payload)
  (let ((http (make-http-connection))
        (response (make-instance 'http-response)))
    (setf (http-url http) (concatenate 'string "https://api.example.com/v1" endpoint))
    (setf (http-method http) :post)
    (setf (http-header http) (list (cons "Authorization" (concatenate 'string "Bearer " api-key)))
                         (cons "Content-Type" "application/json"))
    
    (handler-case
        (progn
          (http-send-request http)
          (setf response (http-get-response http))
          (if (not (member (http-status-code response) '(200 201 204)))
              (error "API Error: ~A ~A" (http-status-code response) (http-get-body response)))
          (json-deserialize (http-get-body response)))
      (error (e)
        (error "Exception: ~A" e)))))
  
