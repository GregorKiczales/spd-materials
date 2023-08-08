;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname m10-find-path-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m10-reverse)
(@cwl ???) ;replace ??? with your cwl


(@problem 1)

;;
;; Complete the design of the rev function below with a function definition.
;; NOTE: We are calling it rev because there is a built-in function called 
;;       reverse that does this same thing, so we can't use that name.
;;
;; Your function definition MUST BE TAIL RECURSIVE.
;;
;; To save you a little time we have already done the first step of the
;; accumulator template recipe below.
;;
;; You MUST NOT rename the locally defined template function.
;;
(@htdf rev)

(@signature (listof X) -> (listof X))
;; produce list of same elements in the opposite order
(check-expect (rev empty) empty)
(check-expect (rev (list 1)) (list 1))
(check-expect (rev (list "a" "b" "c")) (list "c" "b" "a"))

(@template-origin encapsulated (listof X)
           accumulator)

(define (rev lox0)
  ;; don't forget the accumulator type and invariant as well
  ;; as examples here!
  (local [(define (fn-for-lox lox)
            (cond [(empty? lox) (... )]
                  [else
                   (... (first lox)
                        (fn-for-lox (rest lox)))]))]
    
    (fn-for-lox lox0)))
