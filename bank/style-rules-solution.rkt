;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname style-rules-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-p5)
(@cwl ???)

(@problem 1)
;; You're redesigning the SeatNum data definition from lecture, and you're not
;; sure if you've done it correctly. When you ask a TA for feedback, she tells
;; you that you haven't followed our style rules and she asks you to re-format 
;; your data definition before she gives you feedback.
;;
;; a) Why is it important to follow style rules?
;;
;; SOLUTION:
;; 
;; Programming is an inherently social activity and therefore programs are
;; written to be read by people (and run by computers). Programs are much easier
;; to read when the style rules are consistently followed, so style rules or  
;; conventions are common through the world of software development.
;;
;; b) Fix the data definition below so that it follows our style rules. Be sure
;; to consult the style rules page so that you make ALL the required changes, of
;; which there are quite a number.


(@htdd SeatNum)
;; SeatNum is Natural
;; interp. seat numbers in a row, where 1 and 32 are aisle seats
;; CONSTRAINT: SeatNum is in [1,32]
(define SN1 1)
(define SN2 32)

(@dd-template-rules atomic-non-distinct) ;Natural


(define (fn-for-seat-num sn)
  (... sn)) 


