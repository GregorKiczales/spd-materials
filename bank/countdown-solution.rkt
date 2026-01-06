;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/htdd-l5)
(@cwl ???)

(@problem 1)
;; Consider designing the system for controlling a New Year's Eve
;; display. Design a data definition to represent the current state 
;; of the countdown, which falls into one of three categories: 
;;
;;  - not yet started
;;  - from 10 to 1 seconds before midnight
;;  - complete (Happy New Year!)


;; =================
;; Data definitions:

(@htdd Countdown)
;; Countdown is one of:
;;  - false
;;  - Natural
;;  - "complete"
;; interp.
;;    false           means countdown has not yet started
;;    Natural         means countdown is running and how many seconds left
;;    "complete"      means countdown is over
;; CONSTRAINT: Natural is in [1, 10]
(define CD1 false)
(define CD2 10)          ;just started running
(define CD3  1)          ;almost over
(define CD4 "complete")

(@dd-template-rules one-of              ;3 cases
                    atomic-distinct     ;false
                    atomic-non-distinct ;Natural
                    atomic-distinct)    ;"complete"

#;
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(number? c) (... c)]
        [else (...)]))
