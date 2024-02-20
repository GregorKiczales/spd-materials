;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m01-htdf-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment lectures/m01-htdf);Do not edit or remove this tag

(@problem 1)
;;
;; Design a function, called topple, that takes an image and rotates it 
;; by 90 degrees.
;;


(@htdf topple)
(@signature Image -> Image)
;; produce image rotated by 90 degrees
(check-expect (topple (rectangle 10 20 "solid" "red"))
              (rectangle 20 10 "solid" "red"))
(check-expect (topple (triangle 20 "solid" "red"))
              (rotate 90 (triangle 20 "solid" "red")))

;(define (topple img) empty-image) ;stub

(@template-origin Image)

(@template
 (define (topple img)
   (... img)))

(define (topple img)
  (rotate 90 img))



(@problem 2)
;;
;; Design a function, that consumes an image and determines whether it is tall.
;; 
(@htdf tall?)
(@signature Image -> Boolean)
;; produce true if image is tall (height > width)
(check-expect (tall? (rectangle 10 20 "outline" "black")) true)
(check-expect (tall? (rectangle 10  9 "outline" "black")) false)
(check-expect (tall? (rectangle 10 10 "outline" "black")) false)
(check-expect (tall? (rectangle 10 11 "outline" "black")) true)
(check-expect (tall? (rectangle 30 20 "outline" "black")) false)

;(define (tall? i) false) ;stub

(@template-origin Image)

(@template
 (define (tall? i)
   (... i)))

(define (tall? i)
  (> (image-height i) (image-width i)))




(@problem 3)
;;
;; Design a function, called image>?, that takes two images and determines 
;; whether the first is larger than the second.
;;
(@htdf image>?)
(@signature Image Image -> Boolean)
;; produce true if i1 is larger than i2 (comparing areas with >)
(check-expect (image>? empty-image empty-image) false)
(check-expect (image>? (rectangle 10 21 "outline" "black")
                       (rectangle 10 20 "outline" "black"))
              true)
(check-expect (image>? (rectangle 10 20 "outline" "black")
                       (rectangle 10 20 "outline" "black"))
              false)
(check-expect (image>? (rectangle 10 19 "outline" "black")
                       (rectangle 10 20 "outline" "black"))
              false)

;(define (image>? i1 i2) false)

(@template-origin Image)

(@template
 (define (image>? i1 i2)
   (... i1 i2)))

(define (image>? i1 i2)
  (> (* (image-width i1) (image-height i1))
     (* (image-width i2) (image-height i2))))








