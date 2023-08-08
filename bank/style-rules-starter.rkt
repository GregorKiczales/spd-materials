;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname style-rules-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; b) Fix the data definition below so that it follows our style rules. Be sure
;; to consult the style rules page so that you make ALL the required changes, of
;; which there are quite a number.


(@htdd seatnum)
;seatnum is a natural
;interp. The number of a seat in a row, restricted to [1, 32].
;Seats 1 and 32 are aisle seats.
(define sn1 1)
(define sn2 32)

(@dd-template-rules atomic-non-distinct) ;natural

#;
(define (fn-sn x)
  (... x)) 

