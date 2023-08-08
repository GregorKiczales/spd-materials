;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname evaluate-boo-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/evaluate-boo)
(@cwl ???)

(check-expect (+ 1 2) 3) ;this just here so that the default autograder
                         ;likes this file

;; Given the following function definition:
;;
;; (define (boo x lon)
;;   (local [(define (addx n) (+ n x))]
;;     (if (zero? x)
;;         empty
;;         (cons (addx (first lon))
;;               (boo (sub1 x) (rest lon)))))) 

(@problem 1)
;; What is the value of the following expression:
;;
;; (boo 2 (list 10 20))
;;
;; NOTE: We are not asking you to show the full step-by-step evaluation for 
;; this problem, but you may want to sketch it out to help you get these 
;; questions right.


(list 12 21)


(@problem 2)
;; How many function definitions are lifted during the evaluation of the 
;; expression in part A.


3


(@problem 3)
;; Write out the lifted function definition(s). Just the actual lifted function 
;; definitions. 


(define (addx_0 n) (+ n 2))
(define (addx_1 n) (+ n 1))
(define (addx_2 n) (+ n 0))

