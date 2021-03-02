#lang racket
(define v (vector 2 'a (+ 1 2)))
;(let ((x (vector 2 3 5))))

(let ((x (vector 'a 'b 'c 'd 'e))) (display x))
(let ((a 1) (b 2)) (+ a b) (* a b)) 
(vector-set! v 2 10)
(vector-length v)
(vector-ref v 2)
;(display v)

(define light-switch (let ((lit #f)) (lambda ()
(set! lit (not lit))
(if lit (display "on") (display "off")))))


;(light-switch)
;(set! lit (not lit))
;(light-switch)

(define fibonacci
(lambda (n)
(if (= n 0)
0
(do ((i n (- i 1)) ; i=1, --i
(a1 1 (+ a1 a2)) ; a1=1, a1+=a2
(a2 0 a1)) ; a2=0, a2=a1
((= i 1) a1)))))

(fibonacci 6)
;(i n (- i 1))



(define vector-fill!
(lambda (v x)
(let ((n (vector-length v)))
(do ((i 0 (+ i 1)))
((= i n) (display "values equal"))
(vector-set! v i x)))))

(cons 'a '(b c)); ((a 2) (b 3)) (+ a b))


(display v)
(vector-fill! v 0)
(display v)

(let ft ((k 3))
(if (<= k 0)
1
(* k (ft (- k 1)))))


(define vec->li
(lambda (s)
(do ((i (- (vector-length s) 1) (- i 1))
(ls '() (cons (vector-ref s i) ls)))
((< i 0) ls))))

(define (ask-number)
(display "Enter a number: ")
(let ((n (read)))
(if (number? n) n (ask-number))))

(define q '(a b (c d) (e)))
(cadddr q)
       