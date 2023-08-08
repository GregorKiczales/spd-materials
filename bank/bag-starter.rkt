;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname bag-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/abstraction-p6)
(@cwl ???)

;; Given the following partial data definitions:

;; =================
;; Data definitions:

(@htdd Bag)
(define-struct bag (l w h))
;; Bag is (make-bag Number Number Number)
;; interp. a bag with a length, width and height in centimeters
(define B1 (make-bag 19.5 10.0 6.5))
(define B2 (make-bag 23.0 11.5 7.0))
(define B3 (make-bag 18.0 9.5 5.5))


(@htdd ListOfBag)
;; ListOfBag is one of:
;; - empty
;; - (cons Bag ListOfBag)
;; interp. a list of bags
(define LOB1 empty)
(define LOB2 (list B1 B2 B3))



;; =================
;; Functions:

(@problem 1)
;; The linear length of a bag is defined to be its length plus 
;; width plus height. Design the function linear-length-lob that consumes 
;; a list of bags and produces a list of the linear lengths of each of
;; the bags in the list.
;;
;; Use at least one built-in abstract function and encapsulate any helper
;; functions in a local expression.





