;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname using-built-ins-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/abstraction-l2)
(@cwl ???)

;; Some setup data and functions to enable more interesting examples
;; below

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 30 20 "solid" "yellow"))
(define I3 (rectangle 40 50 "solid" "green"))
(define I4 (rectangle 60 50 "solid" "blue"))
(define I5 (rectangle 90 90 "solid" "orange"))

(define LOI1 (list I1 I2 I3 I4 I5))


(@htdf wide?)
(@signature Image -> Boolean)
;; produce true if image is wide
(check-expect (wide? I1) false)
(check-expect (wide? I5) false)
(check-expect (wide? I2) true)

(@template-origin Image)

(define (wide? img) (> (image-width img) (image-height img)))


(@htdf tall?)
(@signature Image -> Boolean)
;; produce true if image is tall
(check-expect (tall? I3) true)
(check-expect (tall? I5) false)
(check-expect (tall? I4) false)

(@template-origin Image)

(define (tall? img) (< (image-width img) (image-height img)))


(@htdf square?)
(@signature Image -> Boolean)
;; produce true if image is square
(check-expect (square? I1) false)
(check-expect (square? I2) false)
(check-expect (square? I5) true)

(@template-origin Image)

(define (square? img) (= (image-width img) (image-height img)))


(@htdf area)
(@signature Image -> Number)
;; produce area of image
(check-expect (area I1) 200)
(check-expect (area I2) 600)

(@template-origin Image)

(define (area img)
  (* (image-width img)
     (image-height img)))


;; In addition to map and filter there are several other useful abstract 
;; list functions built into ISL.  These are listed on the Language page
;; of the course web site. Examples of their use are shown below:


(check-expect (map positive? (list 1 -2 3 -4)) (list true false true false))

(check-expect (filter negative? (list 1 -2 3 -4)) (list -2 -4))

(check-expect (foldr + 0 (list 1 2 3)) (+ 1 2 3 0))   ;foldr is abstraction
(check-expect (foldr * 1 (list 1 2 3)) (* 1 2 3 1))   ;of sum and product   


(check-expect (build-list 6 identity) (list 0 1 2 3 4 5))

(check-expect (build-list 4 sqr) (list 0 1 4 9))


(@problem 1)
;; Complete the design of the following functions by coding them using a 
;; built-in abstract list function.


(@htdf wide-only)
(@signature (listof Image) -> (listof Image))
;; produce list of only those images that are wide?
(check-expect (wide-only (list I1 I2 I3 I4 I5)) (list I2 I4))

;(define (wide-only loi) empty) ;stub

(@template-origin use-abstract-fn)

;(define (wide-only loi)        ;template
;  (filter ... loi))

(define (wide-only loi) 
  (filter wide? loi))


(@htdf all-tall?)
(@signature (listof Image) -> Boolean)
;; are all the images in loi tall?
(check-expect (all-tall? LOI1) false)
(check-expect (all-tall? (list I1 I3)) true)

;(define (all-tall? loi) false) ;stub

(@template-origin use-abstract-fn)

(define (all-tall? loi)
  (andmap tall? loi))


(@htdf sum)
(@signature (listof Number) -> Number)
;; sum the elements of a list
(check-expect (sum (list 1 2 3 4)) 10) 

;(define (sum lon) 0)   ;stub

(@template-origin use-abstract-fn)

;(define (sum lon)      ;template
;         (Number Number -> Number)  Number
;  (foldr ...                        ...    lon))

(define (sum lon)
  (foldr + 0 lon))


(@htdf sum-to)
(@signature Natural -> Natural)
;; produce the sum of the first n natural numbers
(check-expect (sum-to 3) (+ 0 1 2))

;(define (sum-to n) 0) ;stub    

(@template-origin use-abstract-fn fn-composition)

;(define (sum-to n)                    ;template
;  (foldr ... ... (build-list n ...)))

(define (sum-to n)
  (foldr + 0 (build-list n identity))) 



