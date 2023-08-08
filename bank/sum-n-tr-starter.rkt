;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname sum-n-tr-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p6)
(@cwl ???)

(@problem 1)
;; Consider the following function that consumes Natural number n and produces
;; the sum of all the naturals in [0, n].
;;
;; Use an accumulator to design a tail-recursive version of sum-n.


(@htdf sum-n)
(@signature Natural -> Natural)
;; produce sum of Natural numbers in [0, n]

(check-expect (sum-n 0) 0)
(check-expect (sum-n 1) 1)
(check-expect (sum-n 3) (+ 3 2 1 0))

;(define (sum-n n) 0) ;stub

(@template-origin Natural)

(define (sum-n n)
  (cond [(zero? n) 0]
        [else
         (+ n
            (sum-n (sub1 n)))])) 
