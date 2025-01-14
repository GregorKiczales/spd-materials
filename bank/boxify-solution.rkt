;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname boxify-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/htdf-p3)
(@cwl ???)

(@problem 1)
(@htdf boxify)
(@signature Image -> Image)
;; Put box 2 pixels wider and taller around given image.
;; NOTE: A solution that follows the recipe but makes the box the same width
;;       and height is also good. It just doesn't look quite as nice. 
(check-expect (boxify (circle 10 "solid" "red")) 
              (overlay (rectangle 22 22 "outline" "black")
                       (circle 10 "solid" "red")))
(check-expect (boxify (star 40 "solid" "gray")) 
              (overlay (rectangle 67 64 "outline" "black")
                       (star 40 "solid" "gray")))

;(define (boxify i) (circle 2 "solid" "green"))

(@template-origin Image)

(@template
 (define (boxify i)
   (... i)))

(define (boxify i)
  (overlay (rectangle (+ (image-width  i) 2)
                      (+ (image-height i) 2)
                      "outline"
                      "black")
           i))
