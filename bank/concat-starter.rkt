;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname concat-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/2-one-of-p1)
(@cwl ???)

(@problem 1)
;; Given the data definition below, design a function called concat that
;; consumes two ListOfString and produces a single list with all the elements 
;; of lsta preceding lstb.
;;
;; (concat (list "a" "b" ...) (list "x" "y" ...)) should produce:
;; 
;; (list "a" "b" ... "x" "y" ...)
;;
;; You are basically going to design the function append using a cross product 
;; of type comments table. Be sure to simplify your design as much as possible.
;; You MUST NOT USE append in your solution!
;;
;; Hint: Think carefully about the values of both lists. You might see a way to 
;; change a cell's content so that 2 cells have the same value.


;; =================
;; Data Definitions:

(@htdd ListOfString)
;; ListOfString is one of:
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings
(define LOS1 empty)
(define LOS2 (cons "a" (cons "b" empty)))



;; =================
;; Functions:
