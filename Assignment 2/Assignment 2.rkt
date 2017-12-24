#lang racket
#|
The chomskys
CSC 133
Assignment 2
|#

#|------------------------------------------------|#
#|-------------------problem 1--------------------|#
#|------------------------------------------------|#
;Sample input (make5 54321 987)

     ; main function to perform the operation x + y in the format
     ; NNN00 + NN = NNNNN where N is some whole number.
     ; returns -2 on failure.
(define(make5 x y)
  (if (or (< (rightMost x) 0)(<(leftMost y) 0)) -2
  (+(rightMost x)(leftMost y))))

     ; Function to perform the opperations (x % 1000)*100 to return the last
     ; three digits of x in the format NNN00 where x=NNN;
     ; returns -1 on failure.
(define(rightMost x)
  (cond ((< x 1000) -1)
        (else (*(modulo x 1000) 100))))

     ; Function to take a number y and perform the operations
     ; (y % 10^(y.length-2))/(10^y.length-2),
     ; to return the first two digits of y in the format NN.
     ; returns -1 on failre
(define(leftMost y)
  (if (< y 100) -1
        (/ (- y (modulo y (expt 10 (-(countDigits y) 2)))) (expt 10 (-(countDigits y) 2)))))

     ; function to divide a number until it reaches a single digit and return
     ; the number of times it was divided.
     ; base case returns 1
(define(countDigits n)
  (if (< n 10) 1
     (+ 1 (countDigits (/ n 10)))))

#|------------------------------------------------|#
#|-------------------problem 2--------------------|#
#|------------------------------------------------|#
;sample input: (concatL '("E" "R" "G") '("e" "r" "g"))
;              (concatL '("E" "R") '("e" "r" "g"))
;              (concatL '("E" "R" "G") '("e" "r"))

(define(concatL L1 L2)
  (cond ((null? L1) L2)
        ((null? L2) L1)
        (else (cons (car L1)(cons (car L2) (concatL (cdr L1) (cdr L2)))))))

#|------------------------------------------------|#
#|-------------------problem 3--------------------|#
#|------------------------------------------------|#
;sample input: (buildList 9 '-)
;              (buildList 3 '())
;              (buil

(define(buildList N E)
  (if (= N 0)'()
      (cons E(buildList (- N 1) E))))

#|------------------------------------------------|#
#|-------------------problem 4--------------------|#
#|------------------------------------------------|#
;sample input: (listpicket 'A '( a b c))
;              (listpicket 'A '( (a v ) m () p l))


(define (listpicket A L)
  (cond ((null? L)'())
        (else (cons A(cons (car L) (listpicket A (cdr L)))))))

#|------------------------------------------------|#
#|-------------------problem 5--------------------|#
#|------------------------------------------------|#
;sample input: (listpicketall 'A '( (a v ) m () p l))
;              (listpicketall '() '( c h (o m) s k y ()))
;              (listpicketall 'A '(e (v (d c (r)) o))


(define (listpicketall A L)
  (cond ((null? L)'())
        ((not(list? L)) L)
        (else (cons A(cons (listpicketall A (car L)) (listpicketall A (cdr L)))))))
;                          ^steps into nested lists^ ^steps through current list^

#|------------------------------------------------|#
#|-------------------problem 6--------------------|#
#|------------------------------------------------|#
;sample input: (define Last(selectN 2)) (Last '( q w e r t y))
(define(selectN N)
  (lambda(L)
    (if (< (listLength L) N) (L)
    (remover N L))))
    
(define (remover N L) 
  (cond ((not (list? L))'())
          ((= N 1) (cdr L))
          (else (remover (- N 1) (cdr L)))))

(define (listLength L)
  (if (null? L) 0
        (+ 1 (listLength (cdr L)))))