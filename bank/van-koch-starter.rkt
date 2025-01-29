;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname van-koch-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/genrec-p2)
(@cwl ???)

(@problem 1)
;; First review the discussion of the Van Koch Line fractal at:
;; https://andrew.wang-hoyer.com/experiments/fractals/.
;;
;; Now design a function to draw a SIMPLIFIED version of the fractal.  
;;
;; Use the link below to view an image of what your function will create:
;;
;; https://cs110.students.cs.ubc.ca/bank/vkline.png
;;       
;; Notice that the difference here is that the vertical parts of the 
;; curve, or segments BC and DE in this figure (use the link below to view):
;;
;; https://cs110.students.cs.ubc.ca/bank/vkcurve.png
;;
;; are just ordinary lines they are not themselves recursive Koch curves. 
;; That ends up making things much simpler in terms of the math required 
;; to draw this curve. 
;;
;; We want you to make the function consume positions using 
;; DrRacket's posn structure. A reasonable data definition for these 
;; is included below.
;; 
;; The signature and purpose of your function should be:
;;
;;
;; (@htdf vkline)
;; (@signature Posn Posn Image -> Image)
;; Add a simplified Koch fractal to image, going from p1 to p2.
;; CONSTRAINT: p1 and p2 have same y-coordinate.
;;
;; (define (vkline p1 p2 img) img) ;stub
;;
;;
;; Include a termination argument for your function.
;;
;; Note: the length of the image you are adding the Koch fractal to is
;;       calculated by (distance p1 p2)
;;
;; We've also given you some constants and two other functions 
;; below that should be useful.


;; Create a simplified Van Koch Line fractal.

;; =================
;; Constants:

(define LINE-CUTOFF 5)

(define WIDTH 300)
(define HEIGHT 200)
(define MTS (empty-scene WIDTH HEIGHT))



;; =================
;; Data definitions:

(@htdd Posn)
;(define-struct posn (x y))   ;struct is already part of racket
;; Posn is (make-posn Number Number)
;; interp. A cartesian position, x and y are screen coordinates.
(define P1 (make-posn 20 30))
(define P2 (make-posn 100 10))




;; =================
;; Functions:

(@htdf distance)
(@signature Posn Posn -> Number)
;; produce the distance between two points
(check-expect (distance P1 P1) 0)
(check-within (distance P1 P2) 82.4621125 0.0000001)

(@template-origin Posn)

(define (distance p1 p2)
  (sqrt (+ (sqr (- (posn-x p2) (posn-x p1)))
           (sqr (- (posn-y p2) (posn-y p1))))))

(@htdf simple-line)
(@signature Posn Posn Image -> Image)
;; add a black line from p1 to p2 on image
(check-expect (simple-line P1 P2 MTS) (add-line MTS 20 30 100 10 "black")) 

(@template-origin Posn)

(define (simple-line p1 p2 img)
  (add-line img (posn-x p1) (posn-y p1) (posn-x p2) (posn-y p2) "black"))
