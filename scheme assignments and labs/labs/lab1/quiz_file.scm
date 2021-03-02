#lang racket
(letrec ((f (lambda (a b)
              (let ((b (* b b)))
                (let* ((a (* a a)) (b (- b a)))
			(if (< a b)
                                (begin (display b) (display " ") (displayln a) (f b a))
                                (list a b))))))) (f 1 2))
