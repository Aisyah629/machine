; Arc Functional Data Processing Pipeline

; --- Data Structures and Utilities ---

defmacro pipeline (steps)
  ` (fn (data) (with x data (| ,@steps )))

defmacro step (code)
  `(fn (x) ,code)

defmacro process (x step-expr)
  `(step-expr x)

; --- Data Types ---

type record (kvs)
  (defrecord kvs kvs)
  (defn field (r k) (get r k nil))
  (defn set-field (r k v) (make record (put r k v)))

; --- Core Data Processing Functions ---

defn filter (pred lst)
  (if (null? lst)
      nil
      (if (pred (car lst))
          (cons (car lst) (filter pred (cdr lst)))
          (filter pred (cdr lst)))))

defn map-list (fn lst)
  (if (null? lst)
      nil
      (cons (fn (car lst)) (map-list fn (cdr lst)))))

defn reduce (fn init lst)
  (if (null? lst)
      init
      (reduce fn (fn init (car lst)) (cdr lst))))

defn sort-by (fn lst)
  (if (null? lst)
      nil
      (let pivot (car lst)
        (append (filter (fn x (< (fn x) (fn pivot))) lst)
                (list pivot)
                (filter (fn x (>= (fn x) (fn pivot))) lst)))))

; --- Example Usage and Demonstration ---

defn main ()
  (let data (list (list 'name 'Alice 'age 30 'score 85)
                  (list 'name 'Bob 'age 25 'score 92)
                  (list 'name 'Charlie 'age 35 'score 78)
                  (list 'name 'Diana 'age 28 'score 88)))
    
    ; Define pipeline steps
    (let score-filter (step (fn (r) (>= (field r 'score) 80)))
         (let age-filter (step (fn (r) (> (field r 'age) 25)))
              (let score-sort (step (fn (lst) (sort-by (fn (r) (field r 'score)) lst)))
                   (let result (pipeline `(,score-filter ,age-filter ,score-sort) data)
                     (print "Processed Records:")
                     (each r result (print (field r 'name) "-" (field r 'score))))))))

(main)
