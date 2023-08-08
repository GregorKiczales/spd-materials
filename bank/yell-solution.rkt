;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname yell-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-l1)
(@cwl ???)

(@problem 1)
(@htdf yell)
(@signature String -> String)  
;; add "!" to the end of s
(check-expect (yell "hello") "hello!")
(check-expect (yell "bye") (string-append "bye" "!"))

;(define (yell s)  ;stub
;  "a")

(@template-origin String)

(@template (define (yell s)
             (... s)))

(define (yell s)
  (string-append s "!"))
