;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname area-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-l2)
(@cwl ???)

(@problem 1)
(@htdf area)
(@signature Number -> Number)
;; produce area of square with side length s
(check-expect (area 2) (* 2 2))
(check-expect (area 2.5) (* 2.5 2.5))

;(define (area s) ; stub
;  2)

(@template-origin Number)

(@template (define (area s)
             (... s)))

(define (area s)
  (* s s))
