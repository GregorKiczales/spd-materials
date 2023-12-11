;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname mt2-p3-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; DO NOT PUT ANYTHING PERSONALLY IDENTIFYING BEYOND YOUR CWL IN THIS FILE.
(require spd/tags)

(@assignment bank/evaluate-local-3)
(@cwl ???)

(@problem 1)


;;
;; Given the following definition:
;;

(define (foo x y)
  (local [(define (bar x z)
            (list x y z))
          (define (baz x y)
            (local [(define (bar z)
                      (list x y z))]
              (* 2 x y)))]
    (bar x (baz x y))))

#|

 Now consider the evaluation of the following expression.  During this
 evaluation, some number of definitions will be lifted.  In the space below
 below write the lifted definitions and ONLY THE LIFTED DEFINITIONS.

|#

(foo 1 2)

;; write ALL THE LIFTED DEFINITIONS BELOW HERE




;; write ALL THE LIFTED DEFINITIONS ABOVE HERE




#| ;DO ANY SCRATCH WORK BELOW THIS LINE



|# ;DO ANY SCRATCH WORK ABOVE THIS LINE
