;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname replicate-elm-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/accumulators-p2)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a list of elements and a natural n, and
;; produces a list where each element is replicated n times. 
;;
;; (replicate-elm (list "a" "b" "c") 2) should produce
;; (list "a" "a" "b" "b" "c" "c")


(@htdf replicate-elm)
(@signature (listof X) Natural -> (listof X))
;; produce list where elements of lox are replicated n times
(check-expect (replicate-elm empty 1) empty)
(check-expect (replicate-elm (list "a" "b" "c") 2)
              (list "a" "a" "b" "b" "c" "c"))
(check-expect (replicate-elm (list 1 2 3 4 5) 1) (list 1 2 3 4 5)) 

;(define (replicate-elm lox) empty) ;stub

(@template-origin accumulator (listof X))

(define (replicate-elm lox0 n)
  ;; acc: Natural; the number of times (first lox) will be replicated
  ;; (replicate-elm (list "a" "b" "c") 2)  ;outer call
  ;;
  ;; (replicate-elm (list "a" "b" "c") 2) ;replicate "a"
  ;; (replicate-elm (list "a" "b" "c") 1) ;replicate "a"
  ;; (replicate-elm (list "a" "b" "c") 0) ;don't replicate "a"
  ;; (replicate-elm (list     "b" "c") 2) ;...
  ;; (replicate-elm (list     "b" "c") 1)
  ;; (replicate-elm (list     "b" "c") 0) 
  ;; (replicate-elm (list         "c") 2)
  ;; (replicate-elm (list         "c") 1)
  ;; (replicate-elm (list         "c") 0) 
  (local [(define (replicate-elm lox acc)
            (cond [(empty? lox) empty]
                  [else
                   (if (zero? acc)
                       (replicate-elm (rest lox) n)
                       (cons (first lox)
                             (replicate-elm lox
                                            (sub1 acc))))]))]
    
    (replicate-elm lox0 n))) 
