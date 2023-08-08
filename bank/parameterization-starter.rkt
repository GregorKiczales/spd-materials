;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname parameterization-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/abstraction-l1)
(@cwl ???)

(* pi (sqr 4)) ;area of circle radius 4
(* pi (sqr 6)) ;area of circle radius 6


;; ====================

(@htdf contains-ubc?)
(@signature (listof String) -> Boolean)
;; produce true if los includes "UBC"
(check-expect (contains-ubc? empty) false)
(check-expect (contains-ubc? (cons "McGill" empty)) false)
(check-expect (contains-ubc? (cons "UBC" empty)) true)
(check-expect (contains-ubc? (cons "McGill" (cons "UBC" empty))) true)

;(define (contains-ubc? los) false) ;stub

(@template-origin (listof String))

(define (contains-ubc? los)
  (cond [(empty? los) false]
        [else
         (if (string=? (first los) "UBC")
             true
             (contains-ubc? (rest los)))]))


(@htdf contains-mcgill?)
(@signature (listof String) -> Boolean)
;; produce true if los includes "McGill"
(check-expect (contains-mcgill? empty) false)
(check-expect (contains-mcgill? (cons "UBC" empty)) false)
(check-expect (contains-mcgill? (cons "McGill" empty)) true)
(check-expect (contains-mcgill? (cons "UBC" (cons "McGill" empty))) true)

;(define (contains-mcgill? los) false) ;stub

(@template-origin (listof String))

(define (contains-mcgill? los)
  (cond [(empty? los) false]
        [else
         (if (string=? (first los) "McGill")
             true
             (contains-mcgill? (rest los)))]))



;; ====================

(@htdf squares)
(@signature (listof Number) -> (listof Number))
;; produce list of sqr of every number in lon
(check-expect (squares empty) empty)
(check-expect (squares (list 3 4)) (list 9 16))

;(define (squares lon) empty) ;stub

(@template-origin (listof Number))

(define (squares lon)
  (cond [(empty? lon) empty]
        [else
         (cons (sqr (first lon))
               (squares (rest lon)))]))


(@htdf square-roots)
(@signature (listof Number) -> (listof Number))
;; produce list of sqrt of every number in lon
(check-expect (square-roots empty) empty)
(check-expect (square-roots (list 9 16)) (list 3 4))

;(define (square-roots lon) empty) ;stub

(@template-origin (listof Number))

(define (square-roots lon)
  (cond [(empty? lon) empty]
        [else
         (cons (sqrt (first lon))
               (square-roots (rest lon)))]))



;; ====================

(@htdf positive-only)
(@signature (listof Number) -> (listof Number))
;; produce list with only positive? elements of lon
(check-expect (positive-only empty) empty)
(check-expect (positive-only (list 1 -2 3 -4)) (list 1 3))

;(define (positive-only lon) empty) ;stub

(@template-origin (listof Number))

(define (positive-only lon)
  (cond [(empty? lon) empty]
        [else
         (if (positive? (first lon))
             (cons (first lon)
                   (positive-only (rest lon)))
             (positive-only (rest lon)))]))


(@htdf negative-only)
(@signature (listof Number) -> (listof Number))
;; produce list with only negative? elements of lon
(check-expect (negative-only empty) empty)
(check-expect (negative-only (list 1 -2 3 -4)) (list -2 -4))

;(define (negative-only lon) empty) ;stub

(@template-origin (listof Number))

(define (negative-only lon)
  (cond [(empty? lon) empty]
        [else
         (if (negative? (first lon))
             (cons (first lon)
                   (negative-only (rest lon)))
             (negative-only (rest lon)))]))
