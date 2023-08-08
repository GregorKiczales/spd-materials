;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname odd-from-n-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/naturals-p3)
(@cwl ???)

(@problem 1)
;; Design a function called odd-from-n that consumes a natural number n, and 
;; produces a list of all the odd numbers from n down to 1. 
;; 
;; Note that there is a primitive function, odd?, that produces true
;; if a natural number is odd.


(@htdf odd-from-n)
(@signature Natural -> ListOfNatural)
;; produce a list of the odd numbers between n and 1
(check-expect (odd-from-n 0) empty)
(check-expect (odd-from-n 7) (list 7 5 3 1))
(check-expect (odd-from-n 8) (list 7 5 3 1))

;(define (odd-from-n n) empty)

(@template-origin Natural)

(define (odd-from-n n)
  (cond [(zero? n) empty]
        [else
         (if (odd? n)
             (cons n (odd-from-n (sub1 n)))
             (odd-from-n (sub1 n)))]))
