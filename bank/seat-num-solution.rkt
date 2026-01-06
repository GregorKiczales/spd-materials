;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname seat-num-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-l3)
(@cwl ???)

(@problem 1)
;; Imagine that you are designing a program to manage ticket sales for a
;; theatre. (Also imagine that the theatre is perfectly rectangular in shape!) 
;;
;; Design a data definition to represent a seat number in a row, where each 
;; row has 32 seats. (Just the seat number, not the row number.)
 

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
