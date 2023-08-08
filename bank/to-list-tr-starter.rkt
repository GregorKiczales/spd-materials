;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname to-list-tr-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p8)
(@cwl ???)

(@problem 1)
;; Consider the following function that consumes Natural number n and produces
;; a list of all the naturals of the form (list 1 2 ... n-1 n) not including 0.
;;
;; Use an accumulator to design a tail-recursive version of to-list.


(@htdf to-list)
(@signature Natural -> (listof Natural))
;; produce (cons n (cons n-1 ... empty)), not including 0
(check-expect (to-list 0) empty)
(check-expect (to-list 1) (list 1))
(check-expect (to-list 3) (list 1 2 3))

;(define (to-list n) empty) ;stub

(@template-origin Natural)

(define (to-list n)
  (cond [(zero? n) empty]
        [else
         (append (to-list (sub1 n))
                 (list n))]))
