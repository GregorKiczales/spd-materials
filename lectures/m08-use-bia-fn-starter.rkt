;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m08-raining-eggs-refactor-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment lectures/m08-use-bia-fn)

(@cwl ???) ;replace ??? with your cwl

#|
Complete the design of each of the following functions.  You MUST use the 
template origin provided, which is always either use-abstract-fn or
fn-composition use-abstract-fn.  To help you learn how to write functions
that use built-in abstract functions we  provide the template or other
suggestions in some of the problems.

When choosing built-in abstract functions yourselves remember:

 - map always produces a list of the same length as it's argument
 - filter produces a list of all, some or none of the elements in its 
   argument
 - foldr can produce any kind of value at all
 - andmap and ormap produce boolean values
 - buildlist produces a list with the same number of elements as its
   argument

|#

(define CIRCLE (circle 10 "solid" "red"))

(@problem 1)
(@htdf odds-minus-evens)
(@signature (listof Integer) -> Integer)
;; add all odd numbers, subtract all evens
(check-expect (odds-minus-evens (list 3)) 3)
(check-expect (odds-minus-evens (list 2)) -2)
(check-expect (odds-minus-evens (list 1 4 5 2)) 0)

(@template-origin use-abstract-fn)


;; (list 1 2 3 4) -> -2
;;
;; this is a foldr, we fold the strip of numbers down onto a single value
;;
;; for this problem we have done significant templating for you already
;; this is the kind of templating you should normally do on your own
;; when you do a use-abstract-fn problem
;;
;; use the abstract fn signature to help you figure out the signature
;; of the helper function. figure out the purpose of that function.
;; then template it.
;;
(define (odds-minus-evens loi)
  ;; general foldr signature:
  ;;  (X Y -> Y) Y (listof X) -> Y
  ;; adapted to this case:
  ;;  (Number Number -> Number) Number (listof Number) -> Number
  (local [;; (@signature Number Number -> Number)
          ;; add odds to result of natural recursion, subtract evens
          (@template Number)
          (define (+odd/-even x y)
            (... x y))]
            
    (foldr fn 0 loi)))



(@problem 2)
(@htdf sum-larger-than)
(@signature Integer (listof Integer) -> Integer)
;; produce sum of all elements of loi > n
(check-expect (sum-larger-than 4 (list 3)) 0)
(check-expect (sum-larger-than 5 (list 5)) 0)
(check-expect (sum-larger-than 6 (list 6)) 0)
(check-expect (sum-larger-than 3 (list 1 2 3 4 5)) 9)

(define (sum-larger-than n loi) 0)

;; Assume n is 3
;; (list 1 5 2 6) -> (list 5 6) -> 11
;;
;; first filter, then foldr

(@template-origin fn-composition use-abstract-fn)

(define (sum-larger-than n lon)
  (foldr ... ... (filter ... lon)))


(@problem 3)
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

(define (boxes n) empty-image) ; stub

(@template-origin fn-composition use-abstract-fn)

;;
;; 3 -> (list 0 1 2) -> (list 1 11 21) ->
;;      (list (square 1 "outline" "black")
;;            (square 11 "outline" "black")
;;            (square 21 "outline" "black")) ->
;;      (overlay (square 21 "outline" "black")
;;               (square 11 "outline" "black")
;;               (square  1 "outline" "black"))
;;
;; which is (foldr (map ... (map ... (build-list n ...))))
;;
;; OR
;; 3 -> (list (square 1 "outline" "black")
;;            (square 11 "outline" "black")
;;            (square 21 "outline" "black")) ->
;;      (overlay (square 21 "outline" "black")
;;               (square 11 "outline" "black")
;;               (square  1 "outline" "black"))
;;
;; which is (foldr ... ... (build-list n ...))
;;

#;
(define (boxes n)
  (foldr ... ... (build-list n ...)))


(@problem 4)
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

(define (pyramid n) empty-image)
;;
;; this function has to make a stack of n rows, and each row has
;; to have n elements.  So it will have two compositions of foldr
;; and build-list.
;;

(@template-origin fn-composition use-abstract-fn)

;;
;; NOTE: This function makes a stack n high of rows that can be n
;;       wide.  So if we did it with the recursive Natural template
;;       there would be two functions on that template. One to make
;;       n rows and one to make each row.
;;
;;       Once again we have done some significant templating for you.


(define (pyramid n)
  (local [(define (stack n) (foldr above  empty-image (build-list n row)))
          (define (row   n) (foldr beside empty-image (build-list n ...)))]
    
    ;; the visible pyramid is one smaller than the 
    ;; one that includes the base case empty-images
    (stack ...)))
          

          





