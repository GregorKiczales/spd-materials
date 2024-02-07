;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compound-evaluation-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/compound-evaluation)
(@cwl ???)

(@problem 1)
;;
;; Given the definitions below, write the step-by-step evaluation of
;; the expression that follows it.
;;
;; Be sure not to comment out the definitions, not to comment out or delete
;; the original expression, show every intermediate evaluation step, and the
;; final result.  The steps MUST NOT be in comments.
;;
;; Stepping questions like this one have ONLY ONE CORRECT ANSWER.  The goal
;; of this problem is to assess whether you have learned the exact BSL step
;; by step evaluation rules; not whether you can figure out the final result
;; of an expression.
;;

(define-struct census-data (city population))

(define (add-newborn cd)
  (make-census-data (census-data-city cd)
                    (add1 (census-data-population cd))))


(add-newborn (make-census-data "Vancouver" 603502))
