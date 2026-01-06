;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown-to-display-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/htdd-l8)
(@cwl ???)

(@problem 1)
;; You are asked to contribute to the design for a very simple New Year's
;; Eve countdown display. You already have the data definition given below. 
;; You need to design a function that consumes Countdown and produces an
;; image showing the current status of the countdown. 


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



;; =================
;; Functions:

(@htdf countdown->image)
(@signature Countdown -> Image)
;; produce nice image of current state of countdown
(check-expect (countdown->image false) empty-image)
(check-expect (countdown->image 5) (text (number->string 5) 24 "black"))
(check-expect (countdown->image "complete") (text "Happy New Year!!!" 24 "red"))

;(define (countdown->image c) empty-image) ;stub

(@template-origin Countdown)

(@template
 (define (countdown->image c)
   (cond [(false? c) (...)]
         [(number? c) (... c)]
         [else (...)])))

(define (countdown->image c)
  (cond [(false? c)  empty-image]
        [(number? c) (text (number->string c) 24 "black")]
        [else
         (text "Happy New Year!!!" 24 "red")]))
