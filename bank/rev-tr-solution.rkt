;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname rev-tr-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p10)
(@cwl ???)

(@problem 1)
;; Design a function that consumes (listof X) and produces a list of the same 
;; elements in the opposite order. Use an accumulator. Call the function rev. 
;; (DrRacket's version is called reverse.) Your function should be tail
;; recursive.
;;  
;; In this problem only the first step of templating is provided.


(@htdf rev)
(@signature (listof X) -> (listof X))
;; produce list with elements of lox in reverse order
(check-expect (rev empty) empty)
(check-expect (rev (list 1)) (list 1))
(check-expect (rev (list "a" "b" "c")) (list "c" "b" "a"))

;(define (rev lox) empty) 

(@template-origin (listof X) accumulator)

(define (rev lox0)
  ;; acc: (listof X); the reversed elements of lox0 left of lox
  ;; (rev (list "a" "b" "c") empty)
  ;; (rev (list     "b" "c") (list "a"))
  ;; (rev (list         "c") (list "b" "a"))
  ;; (rev empty              (list "c" "b" "a"))
  (local [(define (rev lox acc)
            (cond [(empty? lox) acc]
                  [else
                   (rev (rest lox)
                        (cons (first lox) acc))]))]
    (rev lox0 empty)))
