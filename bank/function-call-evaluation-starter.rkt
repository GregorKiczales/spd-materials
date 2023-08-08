;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname foo-evaluation-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/function-call-evaluation)
(@cwl ???)

(@problem 1)
;;
;; Given the definition below, write the step-by-step evaluation of
;; the expression that follows it.
;;
;; Be sure not to comment out the definition, not to comment out or delete
;; the original expression, show every intermediate evaluation step, and the
;; final result.  The steps MUST NOT be in comments.
;;
;; Stepping questions like this one have ONLY ONE CORRECT ANSWER.  The goal
;; of this problem is to assess whether you have learned the exact BSL step
;; by step evaluation rules; not whether you can figure out the final result
;; of an expression.
;;

(define (foo s)
  (if (string=? (substring s 0 1) "a")
      (string-append s "a")
      s))

(foo (substring "abcde" 0 3))


(@problem 2)
;;
;; Given the definition below, write the step-by-step evaluation of
;; the expression that follows it.
;;
;; Be sure not to comment out the definition, not to comment out or delete
;; the original expression, show every intermediate evaluation step, and the
;; final result.  The steps MUST NOT be in comments.
;;

(define (bee s)
  (substring s 0 1))


(define (bar s t)
  (if (> (string-length s) (string-length t))
      (bee s)
      (bee t)))


(bar "def" "hij")


(@problem 3)
;;
;; Given the definition below, write the step-by-step evaluation of
;; the expression that follows it.
;;
;; Be sure not to comment out the definition, not to comment out or delete
;; the original expression, show every intermediate evaluation step, and the
;; final result.  The steps MUST NOT be in comments.
;;
(define (farfle s)
  (string-append s s))

(farfle (substring "abcdef" 0 2))
