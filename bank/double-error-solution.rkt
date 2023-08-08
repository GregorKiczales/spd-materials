;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname double-error-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-p6)
(@cwl ???)

(@problem 1)
;; There may be more than one problem with this function design. Uncomment 
;; the function design below, and make the minimal changes required to 
;; resolve the error that occurs when you run it.


(@htdf double)
(@signature Number -> Number)
;; produce 2 times n
(check-expect (double 0) 0)
(check-expect (double 4) 8)
(check-expect (double 3.3) (* 2 3.3))
(check-expect (double -1) -2)

;(define (double n) 0) ; stub

(@template-origin Number)

(define (double n)
  (* 2 n))
