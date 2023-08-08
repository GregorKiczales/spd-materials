;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tall-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/htdf-l4)
(@cwl ???)

(@problem 1)
(@htdf tall?)
(@signature Image -> Boolean)
;; produce true if img is tall (height is > width)
(check-expect (tall? (rectangle 20 40 "solid" "red")) true)
(check-expect (tall? (rectangle 40 20 "solid" "red")) false)
(check-expect (tall? (square 40 "solid" "red")) false)

;(define (tall? img) ; stub
;  false)


(@template-origin Image)

(@template (define (tall? img)
             (... img)))

(define (tall? img)
  (> (image-height img) (image-width img)))
