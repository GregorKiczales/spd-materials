;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ensure-question-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-p8)
(@cwl ???)

(@problem 1)
(@htdf ensure-question)
(@signature String -> String)
;; add ? to end of str unless it already ends in ?
;; ASSUME: str is at least 1 long
(check-expect (ensure-question "Hello") "Hello?")
(check-expect (ensure-question "OK?") "OK?")

;(define (ensure-question str) ;stub
;  "str")


(@template-origin String)

(@template
 (define (ensure-question str)
   (... str)))

(define (ensure-question str)
  (if (string=? (substring str (- (string-length str) 1)) "?")
      str
      (string-append str "?")))
