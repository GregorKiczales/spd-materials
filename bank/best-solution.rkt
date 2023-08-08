;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname best-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-l2)
(@cwl ???)

(@problem 1)
;; Using the CityName data definition below design a function
;; that produces true if the given city is the best in the world. 
;; (You are free to decide for yourself which is the best city 
;; in the world.)


;; =================
;; Data definitions:

(@htdd CityName)
;; CityName is String
;; interp. the name of a city
(define CN1 "Boston")
(define CN2 "Vancouver")

; For the first part of the course we want you to list
; the template rules used before each template.

(@dd-template-rules atomic-non-distinct) ;String

#;
(define (fn-for-city-name cn)
  (... cn))



;; =================
;; Functions:

(@htdf best?)
(@signature CityName -> Boolean)
;; produce true if cn is the best city
(check-expect (best? "Boston") false)
(check-expect (best? "Hogsmeade") true)

;(define (best? cn) false)  ;stub

(@template-origin CityName)

(@template
 (define (best? cn)
   (... cn)))

(define (best? cn)
  (string=? cn "Hogsmeade"))
