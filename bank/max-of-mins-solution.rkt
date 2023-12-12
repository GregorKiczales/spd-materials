;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname f-p2-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; DO NOT PUT ANYTHING PERSONALLY IDENTIFYING BEYOND YOUR CWL IN THIS FILE.
(require spd/tags)
(require 2htdp/image)

(@assignment bank/max-of-mins)



(@problem 1)


(@htdf max-of-mins)
(@signature (listof (listof Natural)) -> Natural)
;; produce the largest among the min of each sublist
;; CONSTRAINT: lolon and every sublist must have at least one element
(check-expect (max-of-mins (list (list 2))) 2)
(check-expect (max-of-mins (list (list 3 2 6)
                                 (list 2 40 2 7)
                                 (list 30 20 10)))
              10)

;(define (max-of-mins lolon) 0)

(@template-origin fn-composition use-abstract-fn)

(define (max-of-mins lolon)
  (foldr max 0
         (map (lambda (lon)
                (foldr min (first lon) (rest lon)))
              lolon)))

