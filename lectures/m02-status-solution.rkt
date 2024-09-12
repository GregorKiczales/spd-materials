;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m02-status-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment lectures/m02-status);Do not edit or remove this tag


#|

;; Is this function correct?? (ignore the fact that it is commented out)

(define (can-vote? s)
  (= s 1))




;; How about now? Is it correct now?

(@htdf can-vote?)
(@signature Natural -> Boolean)
;; produces true if a person with given status is eligible to vote
(check-expect (can-vote? 0) false)
(check-expect (can-vote? 1) true)

(@template-origin Natural)

(define (can-vote? s)
  (= s 1))


;; What's the problem?

|#
(@problem 1)
(@htdd Status)
;; Status is one of:
;;  - "minor"
;;  - "adult"
;; interp. the legal status of a person
;; <examples are redundant for enumerations>

(@dd-template-rules one-of           ;2 cases
                    atomic-distinct  ;"minor"
                    atomic-distinct) ;"adult"

(define (fn-for-status s)
  (cond [(string=? s "minor") (...)]
        [(string=? s "adult") (...)]))


(@htdf can-vote?)
(@signature Status -> Boolean)
;; produces true if a person with given status is eligible to vote
(check-expect (can-vote? "minor") false)
(check-expect (can-vote? "adult") true)

(@template-origin Status)

(@template
 (define (can-vote? s)
   (cond [(string=? s "minor") (...)]
         [(string=? s "adult") (...)])))


;; if the template is a cond, from a one-of type you MUST NOT:
;;  - delete the cond
;;  - reorder the QA pairs
;;  - edit the questions
;;  - delete any QA pair
;;  - add any QA pair
;; basically just edit the ...


(define (can-vote? s)
  (cond [(string=? s "minor") false]
        [(string=? s "adult") true]))
