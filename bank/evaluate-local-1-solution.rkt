;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname evaluate-local-1-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/evaluate-local-1)
(@cwl ???)


(@problem 1)

(define (foo n)
  (local [(define (bar x) (* 2 n))]
    (if (even? n)
        n
        (+ n (foo (bar n))))))

(foo 3)

;; 
;; Solution
;; 

(define (bar_0 x) (* 2 3))

(define (bar_1 x) (* 2 6))

