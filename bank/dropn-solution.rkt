;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname dropn-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p1)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a list of elements lox and a natural number
;; n and produces the list formed by dropping every nth element from lox.
;;
;; (dropn (list 1 2 3 4 5 6 7) 2) should produce (list 1 2 4 5 7)


(@htdf dropn)
(@signature (listof X) Natural -> (listof X))
;; produce list formed by dropping every nth element from lox
(check-expect (dropn empty 0) empty)
(check-expect (dropn (list "a" "b" "c" "d" "e" "f") 0) empty)
(check-expect (dropn (list "a" "b" "c" "d" "e" "f") 1) (list "a" "c" "e"))
(check-expect (dropn (list "a" "b" "c" "d" "e" "f") 2) (list "a" "b" "d" "e"))

;(define (dropn lox n) empty) ;stub

(@template-origin (listof X) accumulator)

(define (dropn lox0 n)
  ;; acc: Natural; the number of elements to keep before dropping the next one
  ;; (dropn (list "a" "b" "c" "d") 2)  ;outer call
  ;; 
  ;; (dropn (list "a" "b" "c" "d") 2)  ; keep 
  ;; (dropn (list     "b" "c" "d") 1)  ; keep
  ;; (dropn (list         "c" "d") 0)  ; drop
  ;; (dropn (list             "d") 2)  ; keep
  ;; (dropn (list                ) 1)  ; keep
  (local [(define (dropn lox acc)
            (cond [(empty? lox) empty]
                  [else
                   (if (zero? acc)
                       (dropn (rest lox) n)
                       (cons (first lox)
                             (dropn (rest lox)
                                    (sub1 acc))))]))]
    (dropn lox0 n))) 
