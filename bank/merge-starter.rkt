;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m07-2-one-of-merge-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

(@assignment bank/merge)

(@cwl ???) ;replace ??? with your cwl


(@problem 1)
#|
Design a function that consumes two lists of numbers. Each list
is already sorted in increasing order. The function should produce
the merged list sorted in increasing order.
Show the cross product of type comments table, the simplification,
and the correspondence between table cells and cond cases.

For example:

  (merge (list 2 3 5) (list 1 4 6)) --> (list 1 2 3 4 5 6) 

|#

;; Data Definitions:
;;
;; NOTE: IN 2-ONE-OF PROBLEMS ONLY, WE USE LON FOR ListOfNumber.
;;

(@htdd LON)
;; LON is one of:
;;  - empty
;;  - (cons Number LON)
;; interp. a list of numbers
(define LON1 empty)
(define LONA (list 2 3 5))
(define LONB (list 1 4 6))

;; Function:

(@htdf merge)

(define (merge l1 l2) empty) ;stub
