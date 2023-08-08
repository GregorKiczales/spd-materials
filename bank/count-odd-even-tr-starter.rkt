;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname count-odd-even-tr-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p9)
(@cwl ???)

(@problem 1)
;; Previously we have written functions to count the number of elements in a
;; list. In this problem we want a function that produces separate counts of the
;; number of odd and even numbers in a list, and we only want to traverse the
;; list once to produce that result.
;;
;; Design a tail recursive function that produces the Counts for a given list of
;; numbers. Your function should produce Counts, as defined by the data
;; definition below.
;;
;; There are two ways to code this function, one with 2 accumulators and one
;; with a single accumulator. You should provide both solutions.


(@htdd Counts)
(define-struct counts (odds evens))
;; Counts is (make-counts Natural Natural)
;; interp. describes the number of even and odd numbers in a list

(define C1 (make-counts 0 0)) ;describes an empty list
(define C2 (make-counts 3 2)) ;describes (list 1 2 3 4 5))

#;
(define (fn-for-counts c)
  (... (counts-odds c)
       (counts-evens c)))
