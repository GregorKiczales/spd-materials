;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname pattern-match-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/pattern-match)
(@cwl ???)

(@problem 1)
;; It is often useful to be able to tell whether the first part of a sequence of
;; characters matches a given pattern. In this problem you will design a 
;; (somewhat limited) way of doing this.
;;
;; Assume the following type comments and examples:


;; =================
;; Data Definitions:

(@htdd OneString)
;; OneString is String
;; interp. these are strings only 1 character long
(define 1SA "x")
(define 1SB "2")


(@htdd Pattern)
;; Pattern is one of:
;;  - empty
;;  - (cons "A" Pattern)
;;  - (cons "N" Pattern)
;; interp.
;;   A pattern describing certain ListOfOneString. 
;;  "A" means the corresponding letter must be alphabetic.
;;  "N" means it must be numeric.  For example:
;;      (list "A" "N" "A" "N" "A" "N")
;;   describes Canadian postal codes like:
;;      (list "V" "6" "T" "1" "Z" "4")
(define PATTERN1 (list "A" "N" "A" "N" "A" "N"))


(@htdd ListOfOneString)
;; ListOfOneString is one of:
;;  - empty
;;  - (cons OneString ListOfOneString)
;; interp. a list of strings each 1 long
(define LOS1 (list "V" "6" "T" "1" "Z" "4"))


;; Now design a function that consumes Pattern and ListOfOneString and produces 
;; true if the pattern matches the ListOfOneString. For example,
;;
;; (pattern-match? (list "A" "N" "A" "N" "A" "N")
;;                 (list "V" "6" "T" "1" "Z" "4"))
;; 
;; should produce true. If the ListOfOneString is longer than the pattern, but
;; the first part matches the whole pattern produce true. If the ListOfOneString
;; is shorter than the Pattern you should produce false.       
;;
;; Treat this as the design of a function operating on 2 complex data. After 
;; your signature and purpose, you should write out a cross product of type 
;; comments table. You should reduce the number of cases in your cond to 4 using
;; the table, and you should also simplify the cond questions using the table.
;;
;; You should use the following helper functions in your solution:


;; =================
;; Functions:

(@htdf alphabetic?)
(@signature OneString -> Boolean)
;; produce true if 1s is alphabetic
(check-expect (alphabetic? " ") false)
(check-expect (alphabetic? "1") false)
(check-expect (alphabetic? "a") true)

(@template-origin OneString)

(define (alphabetic? 1s) (char-alphabetic? (string-ref 1s 0)))


(@htdf numeric?)
(@signature OneString -> Boolean)
;; produce true if 1s is numeric
(check-expect (numeric? " ") false)
(check-expect (numeric? "1") true)
(check-expect (numeric? "a") false)

(@template-origin OneString)

(define (numeric? 1s) (char-numeric? (string-ref 1s 0)))
