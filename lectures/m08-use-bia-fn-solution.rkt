;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m08-use-bia-fn-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment lectures/m08-use-bia-fn)

(@cwl ???) ;replace ??? with your cwl

(define CIRCLE (circle 10 "solid" "red"))

(@problem 1)
(@htdf circles)
(@signature (listof Natural) -> (listof Image))
;; produce list of solid blue circles of given radii
(check-expect (circles (list 3))
              (list (circle 3 "solid" "blue")))
(check-expect (circles (list 1 2 10))
              (list (circle 1 "solid" "blue")
                    (circle 2 "solid" "blue")
                    (circle 10 "solid" "blue")))

;(define (circles lon) empty)

(@template-origin use-abstract-fn)

(define (circles lon)
  (local [(@signature Natural -> Image)
          ;; produce one circle of given radius
          (@template-origin Natural)
          (define (one-circle r)
            (circle r "solid" "blue"))]
            
    (map one-circle lon)))


(@problem 2)
(@htdf keep-in-interval)
(@signature Integer Integer (listof Integer) -> (listof Integer))
;; produce list w/ only those numbers in [lo, hi]
(check-expect (keep-in-interval 0 10 (list -1 0 5 10 12)) (list 0 5 10))
(check-expect (keep-in-interval -1 1 (list 3 0 5 1 0)) (list 0 1 0))

;(define (keep-in-interval lo hi lon) empty)

(@template-origin use-abstract-fn)

(define (keep-in-interval lo hi lon)
  (local [(@signature Integer -> boolean)
          ;; produce true if n is in the interval
          (@template-origin Integer)
          (define (in-interval? n)
            (<= lo n hi))]
            
    (filter in-interval? lon)))


(@problem 3)
(@htdf odds-minus-evens)
(@signature (listof Integer) -> Integer)
(check-expect (odds-minus-evens (list 3)) 3)
(check-expect (odds-minus-evens (list 2)) -2)
(check-expect (odds-minus-evens (list 1 4 5 2)) 0)

;(define (odds-minus-evens loi) 0)

(@template-origin use-abstract-fn)

(define (odds-minus-evens loi)
  (local [(define (+/- n rnr)
            (if (odd? n)
                (+ rnr n)
                (- rnr n)))]
    (foldr +/- 0 loi)))



(@problem 4)
(@htdf sum-larger-than)
(@signature Integer (listof Integer) -> Integer) 
;; produce sum of all elements of loi > n
(check-expect (sum-larger-than 4 (list 3)) 0)
(check-expect (sum-larger-than 5 (list 5)) 0)    
(check-expect (sum-larger-than 6 (list 6)) 0)
(check-expect (sum-larger-than 3 (list 1 2 3 4 5)) 9)

(@template-origin fn-composition use-abstract-fn)

(define (sum-larger-than n loi)  
  (local [(define (>n? x) (> x n))] 
    (foldr + 0 (filter >n? loi))))

(@problem 5)
(@htdf fact)
(@signature Natural -> Natural)
;; produce n! (factorial)
(check-expect (fact 0) 1)
(check-expect (fact 3) (* 3 2 1))

(@template-origin fn-composition use-abstract-fn)

(define (fact n)
  (foldr * 1 (build-list n add1)))


(@problem 6)
(@htdf boxes)
(@signature Natural -> Image)   
;; produce n+1 nested boxes, the smallest is quite small
(check-expect (boxes 0) empty-image)
(check-expect (boxes 1) (square 1 "outline" "black"))
(check-expect (boxes 2)
              (overlay (square 11 "outline" "black")
                       (square 1 "outline" "black")))
(check-expect (boxes 3)
              (overlay (square 21 "outline" "black")
                       (square 11 "outline" "black") 
                       (square  1 "outline" "black")))

;(define (boxes n) empty-image) ; stub

(@template-origin fn-composition use-abstract-fn)

(define (boxes n)
  (local [(define (box n)
            (square (+ (* n 10) 1) "outline" "black"))] 
    (foldr overlay empty-image (build-list n box))))  


(@problem 7)
(@htdf pyramid)
(@signature Natural -> Image)
;; produce pyramid of circles n high, w n on bottom row 
(check-expect (pyramid 0) empty-image)
(check-expect (pyramid 1) CIRCLE)
(check-expect (pyramid 2)
              (above CIRCLE
                     (beside CIRCLE CIRCLE)))
(check-expect (pyramid 3)
              (above CIRCLE
                     (beside CIRCLE CIRCLE)
                     (beside CIRCLE CIRCLE CIRCLE)))

;(define (pyramid n) empty-image)

;;
;; this function has to make a stack of n rows, and each row has
;; to have n elements.  So it will have two compositions of foldr
;; and build-list.
;;

(@template-origin fn-composition use-abstract-fn) 

(define (pyramid n)
  (local [(define (one n) CIRCLE)    
          (define (row   n) (foldr beside empty-image (build-list n one)))
          (define (stack n) (foldr above  empty-image (build-list n row)))]
    
    ;; the visible pyramid is one smaller than the 
    ;; one that includes the base case empty-images
    (stack (add1 n))))
