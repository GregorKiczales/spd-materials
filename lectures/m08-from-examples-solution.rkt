;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m08-abstract-functions-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

(@assignment lectures/m08-from-examples)

(@problem 1)

(@htdf all-greater?)
(@signature (listof Number) Number -> Boolean)
;; produce true if every number in lon is greater than x.
(check-expect (all-greater? empty -6) true)
(check-expect (all-greater? (list 2 -3 -4) -6) true)
(check-expect (all-greater? (list -2 -3 -4) -3) false)

(@template-origin use-abstract-fn)

(define (all-greater? lon x)
  ;; NOTE: >x? is a closure, a locally defined function that refers to
  ;;       a parameter or local definition of the surrounding function
  (local [(define (>x? n) (> n x))]
    (andmap2 >x? lon)))




(@htdf all-positive?)
(@signature (listof Number) -> Boolean)
;; produce true if every number in lon is positive
(check-expect (all-positive? empty) true)
(check-expect (all-positive? (list 2 3 -4)) false)
(check-expect (all-positive? (list 2 3  4)) true)

(@template-origin use-abstract-fn)

(define (all-positive? lon)
  (andmap2 positive? lon))


(@problem 2)

(@htdf andmap2)
(@signature (X -> Boolean) (listof X) -> Boolean)
;; given p and (list x0 x1 ...) produce (and (p x0) (p x1) ...)
(check-expect (andmap2 positive? empty) true)
(check-expect (andmap2 positive? (list 2 3 -4)) false)
(check-expect (andmap2 positive? (list 2 3  4)) true)
(check-expect (local [(define (fn n) (> n -3))] (andmap2 fn (list -2 -3 -4)))
              false)
(check-expect (local [(define (fn n) (< n 0))] (andmap2 fn (list -2 -3 -4)))
              true)
(check-expect (andmap2 false? (list true false true)) false)

(@template-origin (listof X))

(define (andmap2 p lox)
  (cond [(empty? lox) true]
        [else
         (and (p (first lox))
              (andmap2 p (rest lox)))]))



(@problem 3)

(@htdf positive-only)
(@signature (listof Number) -> (listof Number))
;; produce list with only positive? elements of lon
(check-expect (positive-only empty) empty)
(check-expect (positive-only (list 1 -2 3 -4)) (list 1 3))

(@template-origin use-abstract-fn)

(define (positive-only lon) 
  (filter2 positive? lon))


(@htdf negative-only)
(@signature (listof Number) -> (listof Number))
;; produce list with only negative? elements of lon
(check-expect (negative-only (list 1 -2 3 -4)) (list -2 -4))

(@template-origin use-abstract-fn)

(define (negative-only lon)
  (filter2 negative? lon)) 


(@htdf filter2)
(@signature (X -> Boolean) (listof X) -> (listof X))
;; produce list of only those elements of lst for which p produces true
(check-expect (filter2 zero?     (list))           (list))
(check-expect (filter2 positive? (list 1 -2 3 -4)) (list 1 3))
(check-expect (filter2 negative? (list 1 -2 3 -4)) (list -2 -4))
(check-expect (filter2 empty?    (list (list 1 2) empty (list 3 4) empty))
              (list empty empty))

(@template-origin (listof X))

(define (filter2 p lox) 
  (cond [(empty? lox) empty]
        [else     
         (if (p (first lox))
             (cons (first lox) 
                   (filter2 p (rest lox)))
             (filter2 p (rest lox)))]))


(@problem 4)
;;
;; Complete the design of the map2 abstract function with signature.
;;


(@htdf squares)
(@signature (listof Number) -> (listof Number))
;; produce list of sqr of every number in lon
(check-expect (squares empty) empty)
(check-expect (squares (list 3 4)) (list 9 16))

(@template-origin use-abstract-fn)

(define (squares lon) (map2 sqr lon))  


(@htdf square-roots)
(@signature (listof Number) -> (listof Number))
;; produce list of sqrt of every number in lon
(check-expect (square-roots empty) empty)
(check-expect (square-roots (list 9 16)) (list 3 4))

(@template-origin use-abstract-fn)

(define (square-roots lon) (map2 sqrt lon)) 



(@htdf map2)
(@signature (X -> Y) (listof X) -> (listof Y))
;; given fn and (list n0 n1 ...) produce (list (fn n0) (fn n1) ...)
(check-expect (map2 sqr empty) empty)
(check-expect (map2 sqr (list 2 4)) (list 4 16))
(check-expect (map2 sqrt (list 16 9)) (list 4 3))
(check-expect (map2 abs (list 2 -3 4)) (list 2 3 4))
(check-expect (map2 string-length (list "foo" "xy")) (list 3 2))

(@template-origin (listof X))

(define (map2 fn lox)
  (cond [(empty? lox) empty]  
        [else
         (cons (fn (first lox))
               (map2 fn (rest lox)))]))

