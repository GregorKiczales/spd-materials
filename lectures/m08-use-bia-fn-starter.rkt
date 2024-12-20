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

When choosing built-in abstract functions remember that:

 - map always produces a list of the same length as its argument.
   In general the elements of the result list are not the same as
   the argument list.

    (map add1 (list 1 2 3)) -> (list 2 3 4))
   
 - filter produces a list of all, some or none of the elements in its 
   argument. The elements of the result list are elements of the 
   argument list.

    (filter odd? (list 1 2 3)) -> (list 1 3)
   
 - foldr can produce any kind of value at all. It folds a list of
   values, one at a time, down onto a result value:

    (foldr + 0 (list 1 2 3)) -> (+ 1 (+ 2 (+ 3 0))) -> 6

 - andmap and ormap produce boolean values

 - buildlist produces a list with the same number of elements as its
   first argument

|#

(define CIRCLE (circle 10 "solid" "red")) ;used in later problem


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

;; Produces list of same length as argument; Every element of result
;; list is a function of corresponding element of argument list.
;; use map
;;
(@template-origin use-abstract-fn)

;;
;; First stage of templating produces this:
;;
#;
(define (circles lon)
  (map ... lon))


;;
;; But then we realize that the helper we need to put in the ... probably does
;; not already exist in the help desk.  So we will have to design a new local 
;; helper for ourselves. So, we update the template to:
;;
#;
(define (circles lon)
  (local [(define (one-circle r)
            (... r))]
    (map one-circle lon)))

;;
;; The signature of map is (X -> Y) (listof X) -> (listof Y)
;; we know that lon is (list of Natural),         so X = Natural
;; we know that we want to produce (listof Image) so Y = Image
;; That tells us the signature our helper has to have and so we
;; can upate the template to:
;;

(define (circles lon)
  (local [(@signature Natural -> Image)
          ;; produce one circle of given radius
          (@template-origin Natural)
          (define (one-circle r)
            (... r))]
    (map one-circle lon)))

;;
;; Now you just need to fill in body of one-circle!
;;


(@problem 2)
(@htdf keep-in-interval)
(@signature Integer Integer (listof Integer) -> (listof Integer))
;; produce list w/ only those numbers in [lo, hi]
(check-expect (keep-in-interval 0 10 (list -1 0 5 10 12)) (list 0 5 10))
(check-expect (keep-in-interval -1 1 (list 3 0 5 1 0)) (list 0 1 0))

;(define (keep-in-interval lo hi lon) empty)

;; Produces list containing some elements of argument.
;; use filter
(@template-origin use-abstract-fn)

(define (keep-in-interval lo hi lon)
  (local [(@signature Integer -> Boolean)
          ;; produce true if n is in the interval
          (@template-origin Integer)
          (define (in-interval? n)
            (... n))]
            
    (filter in-interval? lon)))


(@problem 3)
(@htdf odds-minus-evens)
(@signature (listof Integer) -> Integer)
;; add all odd numbers, subtract all evens
(check-expect (odds-minus-evens (list 3)) 3)
(check-expect (odds-minus-evens (list 2)) -2)
(check-expect (odds-minus-evens (list 1 4 5 2)) 0)

(define (odds-minus-evens lon) 0)

;; Produces non-list given list, all the elements of the list are
;; folded onto the result value.
;; use foldr
(@template-origin use-abstract-fn)



(@problem 4)
(@htdf sum-larger-than)
(@signature Integer (listof Integer) -> Integer)
;; produce sum of all elements of loi > n
(check-expect (sum-larger-than 4 (list 3)) 0)
(check-expect (sum-larger-than 5 (list 5)) 0)
(check-expect (sum-larger-than 6 (list 6)) 0)
(check-expect (sum-larger-than 3 (list 1 2 3 4 5)) 9)

(define (sum-larger-than n loi) 0)

;;
;; Sometimes it produces more clear result code to use a composition of built-in
;; abstract functions.  In cases like that it can help to first think in terms
;; of the succession of values that will flow between those functions. This is
;; such a case. If we assume n is 3, then start with the given list:
;;
;; (list 1 5 2 6) use filter ->
;; (list 5 6) use foldr ->
;; 11
;;
;; first filter, then foldr

(@template-origin fn-composition use-abstract-fn)
#;
(define (sum-larger-than n lon)
  (foldr ... ... (filter ... lon)))


(@problem 5)
(@htdf fact)
(@signature Natural -> Natural)
;; produce n! (factorial)
(check-expect (fact 0) 1)
(check-expect (fact 3) (* 3 2 1))

(@template-origin fn-composition use-abstract-fn)

(define (fact n)
  (foldr ... ... (build-list n ...)))

;; This case uses build-list and foldr.  If it seems unclear first
;; write the intermediate values for (fact 3).




(@problem 6)
(@htdf boxes)
(@signature Natural -> Image)
;; produce n nested boxes, the smallest is quite small
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
;; Some cases can be handled several different ways:
;;
;; 3 use build-list -> 
;; (list 0 1 2) use map ->
;; (list 1 11 21) use map ->
;; (list (square 1 "outline" "black")
;;       (square 11 "outline" "black")
;;       (square 21 "outline" "black")) use foldr ->
;; (overlay (square  1 "outline" "black")
;;          (square 11 "outline" "black")
;;          (square 21 "outline" "black"))
;;
;; which is (foldr ... ... (map ... (map ... (build-list n ...))))
;;
;; But note that the composition of map with map can be replaced by a single
;; map in which the map functions are composed.  Similarly the composition of
;; map with build list can be replaced by a single build-list in which the two
;; map functions are composed. So:
;;
;; (map fn1 (map fn2 (build-list n fn3)))
;;
;; Can be replaced by:
;;
;; (build-list n <a fn that composes (fn1 (fn2 (fn3 ...)))>)
;;
;; Which leads to a series of values as follows:
;;
;; OR
;;
;; 3 use build-list ->
;; (list (square 1 "outline" "black")
;;       (square 11 "outline" "black")
;;       (square 21 "outline" "black")) use foldr ->
;; (overlay (square  1 "outline" "black")
;;          (square 11 "outline" "black")
;;          (square 21 "outline" "black"))
;;
;; which is (foldr ... ... (build-list n ...))
;;

#;
(define (boxes n)
  (foldr ... ... (build-list n ...)))


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
#;
(define (pyramid n)
  (local [(define (stack n) (foldr above  empty-image (build-list n row)))
          (define (row   n) (foldr beside empty-image (build-list n ...)))]
    
    ;; the visible pyramid is one smaller than the 
    ;; one that includes the base case empty-images
    (stack ...)))
          

          





