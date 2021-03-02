#lang racket



(do ((vec (make-vector 5))
     (i 0 (+ i 1)))

    ((= i 5) vec)

  (vector-set! vec i i))

(define vec->li
(lambda (s)
(do (i (- (vector-length s) 1) (- i 1))
(ls '() (cons (vector-ref s i) ls))
((< i 0) ls))))

(define fibonacci
(lambda (n)
(if (= n 0)
0
(do ((i n (- i 1)) ; i=1, --i
(a1 1 (+ a1 a2)) ; a1=1, a1+=a2
(a2 0 a1)) ; a2=0, a2=a1
((= i 1) a1)))))