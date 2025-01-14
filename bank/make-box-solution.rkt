;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname make-box-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/htdf-p7)
(@cwl ???)

(@problem 1)
(@htdf make-box)
(@signature Color -> Image)
;; Create a box of the given color
(check-expect (make-box "red") (square 10 "solid" "red"))
(check-expect (make-box "gray") (square 10 "solid" "gray"))

;(define (make-box c) empty-image)

(@template-origin Color)

(@template
 (define (make-box c)
   (... c)))

(define (make-box c)
  (square 10 "solid" c))
