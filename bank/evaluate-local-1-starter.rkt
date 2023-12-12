;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname evaluate-foo-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/evaluate-local-1)
(@cwl ???)

(@problem 1)

;;
;; Consider the following function definition and a call to that function:
;;

(define (foo n)
  (local [(define (bar x) (* 2 n))]
    (if (even? n)
        n
        (+ n (foo (bar n))))))

(foo 3)

;;
;; During the evaluation of (foo 3) one or more definitions may be lifted.
;; Write those lifted definitions and ONLY those lifted definitions below.
;;


