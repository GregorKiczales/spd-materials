;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname image-area-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/htdf-l3)
(@cwl ???)

(@problem 1)
(@htdf image-area)
(@signature Image -> Natural)
;; produce the area of the consumed image (width * height)
(check-expect (image-area (rectangle 3 4 "solid" "blue")) (* 3 4))

;(define (image-area img) 0) ;stub


(@template-origin Image)

(@template
 (define (image-area img)
   (... img)))

(define (image-area img)
  (* (image-width img)
     (image-height img)))
