;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname decreasing-image-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/naturals-p2)
(@cwl ???)

(@problem 1)
;; Design a function called decreasing-image that consumes a natural n and
;; produces an image of all the numbers from n to 0 side by side. 
;;
;; So (decreasing-image 3) should produce the image found here:
;; https://cs110.students.cs.ubc.ca/bank/3210.png


;; =================
;; Constants:

(define TEXT-SIZE 20)
(define TEXT-COLOR "black")
(define SPACING (text " " TEXT-SIZE TEXT-COLOR))



;; =================
;; Functions:

(@htdf decreasing-image)
(@signature Natural -> Image)
;; produce an image of n, n-1, ... 0 side by side
(check-expect (decreasing-image 0) (text "0" 20 "black"))
(check-expect (decreasing-image 3) (beside (text "3" 20 "black") SPACING 
                                           (text "2" 20 "black") SPACING
                                           (text "1" 20 "black") SPACING
                                           (text "0" 20 "black")))

;(define (decreasing-image n) empty-image)   ; stub

(@template-origin Natural)

(define (decreasing-image n)
  (cond [(zero? n) (text "0" TEXT-SIZE TEXT-COLOR)]
        [else
         (beside (text (number->string n) TEXT-SIZE TEXT-COLOR)
                 SPACING
                 (decreasing-image (sub1 n)))]))
