(define (add a b)
  (+ a b))

(define (subtract a b)
  (- a b))

(define (multiply a b)
  (* a b))

(define (divide a b)
  (/ a b))

(define (evaluate expression)
  (cond
    ((null? expression) 0)
    ((symbol? expression) expression)
    ((number? expression) expression)
    ((list? expression)
     (let ((operator (car expression))
           (args (cdr expression)))
       (cond
         ((eq? operator '+) (apply add args))
         ((eq? operator '-) (apply subtract args))
         ((eq? operator '*) (apply multiply args))
         ((eq? operator '/) (apply divide args))
         (else (error "Unknown operator" operator)))))
    (else (error "Invalid expression" expression))))

(display "Symbolic computation tool ready.\n")
(quit)
