;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname concentric-circles-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/naturals-p4)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a natural number n and a color c, and
;; produces n concentric circles of the given color.
;;
;; So (concentric-circles 5 "black") should produce the image here:
;; https://cs110.students.cs.ubc.ca/bank/con-circ.png
 

(@htdf concentric-circles)
(@signature Natural String -> Image)
;; produce n concentric circles of color c
(check-expect (concentric-circles 0 "red") empty-image)
(check-expect (concentric-circles 2 "purple")
              (overlay (circle 20 "outline" "purple")
                       (circle 10 "outline" "purple")
                       empty-image))
(check-expect (concentric-circles 5 "black")
              (overlay (circle 50 "outline" "black")
                       (circle 40 "outline" "black")
                       (circle 30 "outline" "black")
                       (circle 20 "outline" "black")
                       (circle 10 "outline" "black")
                       empty-image))

;(define (concentric-circles n c) empty-image)   ;stub

(@template-origin Natural)

(define (concentric-circles n c)
  (cond [(zero? n) empty-image]
        [else
         (overlay (circle (* n 10) "outline" c)
                  (concentric-circles (sub1 n) c))]))
