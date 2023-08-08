;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-sequencep-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-sequencep)
(@cwl ???) ;replace ??? with your cwl

(@problem 1)
;;
;; PROBLEM:
;;
;; Design a function called sequence? that consumes a list of natural numbers
;; and produces true if the list is a sequence, meaning each number is 1 larger
;; than the number before it.  Be sure to make (sequence? empty) produce true.
;; So:
;;    (sequence? (list))        ==> true
;;    (sequence? (list 2 3 4))  ==> true
;;    (sequence? (list 3 5 6))  ==> false
;;
