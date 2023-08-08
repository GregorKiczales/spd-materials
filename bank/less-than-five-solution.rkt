;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname less-than-five-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-p2)
(@cwl ???)

(@problem 1)
(@htdf less-than-5?)
(@signature String -> Boolean)
;; produce true if length of s is less than 5
(check-expect (less-than-5? "") true)
(check-expect (less-than-5? "five") true)
(check-expect (less-than-5? "12345") false)
(check-expect (less-than-5? "eighty") false)

;(define (less-than-5? s)  ;stub
;  true)


(@template-origin String)

(@template (define (less-than-5? s)
             (... s)))

(define (less-than-5? s)
  (< (string-length s) 5))
