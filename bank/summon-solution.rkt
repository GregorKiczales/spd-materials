;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname summon-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdf-p1)
(@cwl ???)

(@problem 1)
(@htdf summon)
(@signature String -> String)
;; prepend "accio " to the start of s
(check-expect (summon "Firebolt") "accio Firebolt")
(check-expect (summon "portkey") (string-append "accio " "portkey"))

;(define (summon s)  ;stub
;  "")

(@template-origin String)

(@template
 (define (summon s)
   (... s)))

(define (summon s)
  (string-append "accio " s))
