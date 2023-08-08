;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname l05-clickers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)


;; Academic misconduct (cheating):
;;
;;  - Doesn't hurt anyone, it only changes my grade.
;;
;;  - Hurts other students in the class.
;;
;;  - Hurts the university as a whole.
;;
;;  - Hurts all the other students in the class and the university as a whole.
;;




































;; QUESTION [45 seconds]
;; 
;; Given the following definitions:


(define-struct foo (a b c))

(define F1 (make-foo 1 2 3))
(define F2 (make-foo 4 5 6))


;; Which of the following expressions produces the value 5?
;; 
;; A. (foo-a F1)
;; B. (foo-b)
;; C. (foo-c F2)
;; D. (foo-b F2)

































;; QUESTION [45 seconds]
;;
;; Given the following definitions,
;; what is the value of the following expression?


(define-struct foo (a b c))

(define F1 (make-foo 1 2 3))
(define F2 (make-foo 4 5 6))


(foo-c (make-foo (foo-c F1)
                 (foo-b F2)
                 (foo-a F1)))


;; A. 1
;; B. 2
;; C. 3
;; D. 6
































;; QUESTION [75 seconds]
;;
;; Which of the following definitions for tock ensures that the visible 
;; part of the spider never leaves the bottom of the window?

;; A.
(define (tock s)
  (if (<= (+ s SPEED) (- HEIGHT 1 SPIDER-RADIUS))
      (- HEIGHT 1 SPIDER-RADIUS)
      (+ s SPEED)))

;; B.
(define (tock s)
  (if (>= s (- HEIGHT 1 SPIDER-RADIUS))
      (- HEIGHT 1 SPIDER-RADIUS)
      (+ s SPEED)))

;; C.
(define (tock s)
  (+ s SPEED))

;; D.
(define (tock s)
  (if (>= (+ s SPEED) (- HEIGHT 1 SPIDER-RADIUS))
      (- HEIGHT 1 SPIDER-RADIUS)
      (+ s SPEED)))
