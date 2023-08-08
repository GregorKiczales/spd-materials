;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname blue-triangle-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/htdf-p5)
(@cwl ???)

(@problem 1)
(@htdf blue-triangle)
(@signature Natural -> Image)
;; Given a number, produce a blue solid triangle of that size. 
(check-expect (blue-triangle 7) (triangle 7 "solid" "blue"))
(check-expect (blue-triangle 50) (triangle 50 "solid" "blue"))
(check-expect (blue-triangle 100) (triangle 100 "solid" "blue"))

;(define (blue-triangle n) empty-image) ; stub

(@template-origin Natural)

(@template (define (blue-triangle n)
             (... n)))

(define (blue-triangle n)
  (triangle n "solid" "blue"))
