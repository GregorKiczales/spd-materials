;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname evaluate-foo-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/local-evaluation)
(@cwl ???)

(@problem 1)
#|
Consider the following definition:

(define (foo n)
  (local [(define x (* 3 n))]
    (if (even? x)
        n
        (+ n (foo (sub1 n))))))

Now consider the evaluation of the expression (foo 3).  During that
evaluation one or more definitions may be lifted.  Write those lifted
definitions and only those lifted definitions below.

Stepping questions like this one have ONLY ONE CORRECT ANSWER.  The goal
of this problem is to assess whether you have learned the exact BSL step
by step evaluation rules; not whether you can figure out the final result
of an expression.

|#

;; write your answer below here
