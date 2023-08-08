;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname skip1-v1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-l1)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a list of elements and produces the list
;; consisting of only the 1st, 3rd, 5th and so on elements of its input. 
;;
;;    (skip1 (list "a" "b" "c" "d")) should produce (list "a" "c")


(@htdf skip1)
(@signature (listof X) -> (listof X))
;; produce list consisting of only the 1st, 3rd, 5th... elements of lox
(check-expect (skip1 empty) empty)
(check-expect (skip1 (list "a" "b" "c" "d")) (list "a" "c"))
(check-expect (skip1 (list 1 2 3 4 5 6)) (list 1 3 5)) 

;(define (skip1 lox) empty);stub

(@template-origin (listof X) accumulator)

(define (skip1 lox)
  (cond [(empty? lox) empty]
        [else
         (if (odd? POSITION-OF-FIRST-LOX)
             (cons (first lox)
                   (skip1 (rest lox)))
             (skip1 (rest lox)))])) 


