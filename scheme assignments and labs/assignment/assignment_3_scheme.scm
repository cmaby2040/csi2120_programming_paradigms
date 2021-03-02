
#lang scheme
;Question #1
(define(lover list)
  (map(lambda (list) ; usingt the map function to map new values to the list
        (if (= list 0);condition to see of the elements is zerp
            list       ;just output the regular 0 value
            (/ 1 list)));otherwise 1/the value
      list)) ;value of the list for the function

(lover '(0 2 3 4 12 0 0 1 0)) ;test case

;Question #2
(define TOL 1e-6) ;tolerance definition

(define (newtonRhap x0 f fx) 
  (let ((x1 (- x0 (/ (f x0) (fx x0))))) ;set up od the equation
    (cond ((< (abs (- x1 x0)) TOL) x1) ;a check the difference is greater then tolerance
        (else (newtonRhap x1 f fx)) ;recursive call
        )
    )
  )

(newtonRhap 0.1 sin cos) ;test case 1

(newtonRhap 2.0 (lambda (x) (- (* x x) x 6)) ; test case 2
(lambda (x) (- (* 2 x) 1)))

(newtonRhap -20.0 (lambda (x) (- (* x x) x 6)) ;test case 3
(lambda (x) (- (* 2 x) 1)))

;question #3
(define square (lambda (x) (* x x))) ;side built equation to square values

(define (p_cos val)
    (let ((xi 1))
      (let ((add (- 1 (/ (* 4 (square val)) (* (square pi) (square (- (* 2 xi) 1)))))))
        ;the creation of the value inside the  of the sum for this case
        (addCos val (+ 1 xi) add 1);helper function to the values back
        )
      )
  )

(define (addCos val xi addval prod);helper function definetion
  (let ((addcase (- 1 (/ (* 4 (square val)) (* (square pi) (square (- (* 2 xi) 1)))))));value in func this case
  (cond ((< (abs(- addval addcase)) TOL) (* prod addval));case wher tolerance is meet
        (else (addCos val (+ 1 xi) addcase (* prod addval))
      )
        )
  )
  )

(p_cos 0) ;test case 1

(p_cos (/ pi 2)) ; test case 2

;Question #4

;Part A
(define (separator? value)
  (or (char=? value #\space) ; each case needed
      (char=? value #\tab)
      (char=? value #\newline)
  )
)

(separator? #\space) ; test case 1

(separator? #\b) ; test case 2


;Part B

(define (cpy list)
 (if
  (not
   (separator? (car list));make sure it is not separated
   )
   (cons (car list)(cpy (cdr list)));recursive call and extraction of the element
  '();blank list
  )
  )

(cpy '(#\H #\e #\l #\l #\o #\space #\W #\o #\r #\l #\d)) ; test case

;Part C
(define (drop list)
  (if
   (not
    (separator? (car list));make sure it is not separated
    )
   (drop (cdr list));recursive call
   (cdr list); drop the elements from the list
   )
  )

(drop '(#\H #\e #\l #\l #\o #\newline #\W #\o #\r #\l #\d))

;part D
(define (same? list1 list2)
  (equal? (cpy list1) list2);copy the list cause of an error check if the lists are equal
  )

(same? '(#\H #\e #\l #\l #\o #\tab #\W #\o #\r #\l #\d)
'(#\H #\e #\l #\l #\o))

(same? '(#\H #\e #\l #\l #\o #\space #\W #\o #\r #\l #\d)
'(#\W #\o #\r #\l #\d))

;part E

(define (replace initialArray whereToReplace replaceValue)
  (cond
    (( or (null? (cdr initialArray)) (null? initialArray ) ) initialArray );check for empty list
    ((and (char=? ( car initialArray ) ( car whereToReplace ) ) ( separator? (cadr initialArray)))
     (cons (car replaceValue) (append (cdr replaceValue) (replace (cdr initialArray ) whereToReplace replaceValue)))) ;recursive call and check;
    (else (cons (car initialArray) (replace (cdr initialArray) whereToReplace replaceValue))))) ;recursive call and regular input

(replace
'(#\a #\space #\b #\i #\r #\d #\space #\e #\a #\t #\s #\space
#\a #\space #\t #\o #\m #\a #\t #\o) '(#\a) '(#\t #\h #\e)) ;test case 1