;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname strictly-decreasing-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p3)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a list of numbers and produces true if the 
;; numbers in lon are strictly decreasing. You may assume that the list has at 
;; least two elements.


(@htdf strictly-decreasing?)
(@signature (listof Number) -> Boolean)
;; Produce true if the numbers in lon are strictly decreasing
;; ASSUME: the list has at least two elements
(check-expect (strictly-decreasing? (list 1 1))   false)
(check-expect (strictly-decreasing? (list 1 2))   false)
(check-expect (strictly-decreasing? (list 2 1))   true)
(check-expect (strictly-decreasing? (list 1 2 3)) false)
(check-expect (strictly-decreasing? (list 3 2 1)) true)

(@template-origin (listof Number) accumulator)

(define (strictly-decreasing? lon0)
  ;; prev is Number; the previous number in lon0
  ;; (strictly-decreasing? (list 3 2 1))
  ;;
  ;; (strictly-decreasing? (list 2 1)  true 3)
  ;; (strictly-decreasing? (list   1)  true 2)
  ;; (strictly-decreasing? (list    )  true 1) 
  (local [(define (strictly-decreasing? lon prev)
            (cond [(empty? lon) true]
                  [else
                   (if (< (first lon) prev)
                       (strictly-decreasing? (rest lon) (first lon))
                       false)]))]
    (strictly-decreasing? (rest lon0) (first lon0)))) 
