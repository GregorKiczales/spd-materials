;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname aisle-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-l6)
(@cwl ???)

(@problem 1)
;; Using the SeatNum data definition below design a function
;; that produces true if the given seat number is on the aisle. 


;; =================
;; Data definitions:

(@htdd SeatNum)
;; SeatNum is Natural
;; interp. seat numbers in a row, where 1 and 32 are aisle seats
;; CONSTRAINT: SeatNum is in [1,32]
(define SN1  1) ;aisle
(define SN2 12) ;middle
(define SN3 32) ;aisle

(@dd-template-rules atomic-non-distinct) ;Natural

#;
(define (fn-for-seat-num sn)
  (... sn)) 



;; =================
;; Functions:

(@htdf aisle?)
(@signature SeatNum -> Boolean)
;; produce true if the given seat number is on the aisle
(check-expect (aisle?  1) true)
(check-expect (aisle? 16) false)        
(check-expect (aisle? 32) true)       

;(define (aisle? sn) false)  ;stub

(@template-origin SeatNum)

(@template
 (define (aisle? sn)
   (... sn)))

(define (aisle? sn)
  (or (= sn 1)
      (= sn 32)))
