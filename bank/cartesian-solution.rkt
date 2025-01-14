;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cartesian-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-p9)
(@cwl ???)

(@problem 1)
(@htdf distance)
(@signature Number Number Number Number -> Number)
;; produce cartesian distance between (x1, y1) and (x2, y2)
(check-expect (distance 3 0 0 4) 5)
(check-within (distance 0 1 1 0) (sqrt 2) .00001)

;(define (distance x1 y1 x2 y2) ;stub
;  1)

(@template-origin Number)

(@template
 (define (distance x1 y1 x2 y2)
   (... x1 y1 x2 y2)))

(define (distance x1 y1 x2 y2)
  (sqrt (+ (sqr (- x2 x1))
           (sqr (- y2 y1)))))
