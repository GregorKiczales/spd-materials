;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m04-lon-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

(@assignment lectures/m04-lon)

(@cwl ???) ;replace ??? with your cwl

(@problem 1)

(@htdd ListOfNumber)
;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON1 empty)
(define LON2 (cons 1 (cons 2 (cons 3 empty))))

(@dd-template-rules one-of             ;2 cases
                    atomic-distinct    ;empty
                    compound           ;(cons Number ListOfNumber)
                    self-ref)          ;(rest lon) is ListOfNumber

(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))



;;
;; Design a function that computes the sum of a list of numbers.
;; 

;(@htdf sum)

(@problem 2)
;;
;; Design a function that computes the product of the numbers in a list of
;; numbers.  Note that the product of an empty list of numbers is 1. If
;; this troubles you see https://en.wikipedia.org/wiki/Empty_product
;;

;(@htdf product)


(@problem 3)
;;
;; Design a function that counts the number of elements in a list of numbers.
;; 

;(@htdf count)


(@problem 4)
;;
;; Design a function that produces a new list, where each element  
;; is 2 times the corresponding element in the original list.
;;

;(@htdf doubles)
