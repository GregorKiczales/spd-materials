;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname boolean-list-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/self-ref-p3)
(@cwl ???)

;; =================
;; Data definitions:

(@problem 1)
;; Design a data definition to represent a list of booleans.
;; Call it ListOfBoolean. 


(@htdd ListOfBoolean)
;; ListOfBoolean is one of:
;;  - empty
;;  - (cons Boolean ListOfBoolean)
;; interp. a list of boolean values
(define LOB1 empty)
(define LOB2 (cons true (cons false empty)))

(@dd-template-rules one-of               ;2 cases
                    atomic-distinct      ;empty
                    compound             ;(cons Boolean ListOfBoolean)
                    self-ref)            ;(rest lob) is ListOfBoolean

#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else
         (... (first lob)
              (fn-for-lob (rest lob)))]))



;; =================
;; Functions:

(@problem 2)
;; Design a function that consumes a list of boolean values and produces true 
;; if every value in the list is true. If the list is empty, your function 
;; should also produce true. Call it all-true?


(@htdf all-true?)
(@signature ListOfBoolean -> Boolean)
;; produce true if all values in the given list are true or if the list is empty
(check-expect (all-true? empty) true)
(check-expect (all-true? LOB2) false)
(check-expect (all-true? (cons true (cons true (cons true (cons true empty)))))
              true)

;(define (all-true? lob) true)  ;stub

(@template-origin ListOfBoolean)

(@template
 (define (all-true? lob)
   (cond [(empty? lob) (...)]
         [else
          (... (first lob)
               (all-true? (rest lob)))])))

(define (all-true? lob)
  (cond [(empty? lob) true]
        [else
         (and (first lob)
              (all-true? (rest lob)))]))
