;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname zip-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/zip)
(@cwl ???)

(@problem 1)
;; Given the data definition below, design a function called zip that consumes
;; two lists of numbers and produces a list of Entry, formed from the
;; corresponding elements of the two lists.
;;
;; (zip (list 1 2 ...) (list 11 12 ...)) should produce:
;;
;; (list (make-entry 1 11) (make-entry 2 12) ...)
;;
;; Your design should assume that the two lists have the same length.


;; =================
;; Data Definitions:

(@htdd Entry)
(define-struct entry (k v))
;; Entry is (make-entry Number Number)
;; Interp. an entry maps a key to a value
(define E1 (make-entry 3 12))


(@htdd ListOfEntry)
;; ListOfEntry is one of:
;;  - empty
;;  - (cons Entry ListOfEntry)
;; interp. a list of key value entries
(define LOE1 (list E1 (make-entry 1 11)))


(@htdd ListOfNumber)
;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON0 empty)
(define LON1 (list 1 4 6 2))



;; =================
;; Functions:
