#lang racket
;part 1
(cons '3 '(4))
(cons '1 '(2 3))
(cons 'a '((b c)))
(cons '1 '())
(cons '2 ' ((3(4))))

;part 2
(define L '(1 2 3 4 5))
(define LL '(1(2 3 4)(5)))

(car L)
(cadr L)
(caddr L)
(cadddr L)

(cadr LL)
(caadr LL)
(caaddr LL)

;question #3
(define (range x y)
  (if (> x y)
      '()
      (cons x (range (+ 1 x) y))))

(range 4 9)

(define Q '(1 2(a 3 4 5)))
;(caaddr Q)
(define (quizAnswer list)
  (if (null? list)
      '()
      (caaddr Q)))

(quizAnswer Q)

;lab_11_file

;question #1

(define (loop LA LB)
  (if (or (null? LA) (null? LB))
      '()
      (cons (abs (- (car LA) (car LB))) (loop (cdr LA) (cdr LB)))))

(define (absDiff L1 L2)
  (cond
   ((not (list? L1)) "L1 not a list")
   ((not (list? L2)) "L2 not a list")
   ((not (= (length L1) (length L2))) "List have different length")
   (#t (loop L1 L2))))

(absDiff '(1 3 5 6) '(3 5 2 1))

(absDiff '(1 3 5 6 7) '(3 5 2 1))

;quiz question

 (letrec((f (lambda (a b)
 	(let*((b (* b b)))
		(letrec((a (* a a)) (b (- b a)))
			(if (< a b)
                   (f b a))
                   (list a b))))))  (f 1 2))

