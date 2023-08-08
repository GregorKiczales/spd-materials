;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname van-koch-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/genrec-p2)
(@cwl p9b2b)

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
;; Assume p1 and p2 have same y-coordinate.
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

(@htdf vkline)
(@signature Posn Posn Image -> Image)
;; Add a simplified Koch fractal to image, going from p1 to p2.
;; Assume p1 and p2 have same y-coordinate and LINE-CUTOFF > 0
(check-expect (vkline (make-posn 0 HEIGHT)
                      (make-posn (- LINE-CUTOFF 1) HEIGHT) MTS)
              (simple-line (make-posn 0 HEIGHT)
                           (make-posn (- LINE-CUTOFF 1) HEIGHT)
                           MTS))
(check-expect (vkline (make-posn 0 HEIGHT) (make-posn LINE-CUTOFF HEIGHT) MTS)
              (simple-line (make-posn 0 HEIGHT)
                           (make-posn LINE-CUTOFF HEIGHT)
                           MTS))
(check-expect (vkline (make-posn 0 HEIGHT)
                      (make-posn (* 3 LINE-CUTOFF) HEIGHT)
                      MTS)
              (local [(define HEIGHT2 (/ (distance
                                          (make-posn 0 HEIGHT)
                                          (make-posn (* 3 LINE-CUTOFF) HEIGHT))
                                         3))
                      (define A (make-posn 0 HEIGHT))
                      (define B (make-posn LINE-CUTOFF HEIGHT))
                      (define C (make-posn LINE-CUTOFF
                                           (- HEIGHT HEIGHT2)))
                      (define D (make-posn (* 2 LINE-CUTOFF)
                                           (- HEIGHT HEIGHT2)))
                      (define E (make-posn (* 2 LINE-CUTOFF)
                                           HEIGHT))
                      (define F (make-posn (* 3 LINE-CUTOFF)
                                           HEIGHT))]
                (vkline A B
                        (simple-line B C
                                     (vkline C D
                                             (simple-line D E
                                                          (vkline E F MTS)))))))

;; Termination Argument:
;;   trivial case: distance between p1 and p2 is <= LINE-CUTOFF
;;   reduction step: split distance by into 3 pieces, raise 2nd subset up and  
;;                   recurse on pieces
;;   argument: reduction step reduces the distance between the points so 
;;             eventually the distance will be <= LINE-CUTOFF

(@template-origin genrec)

(define (vkline p1 p2 img)
  (local [(define ln (distance p1 p2))]
    (if (<= ln LINE-CUTOFF)
        (simple-line p1 p2 img)
        (local [(define lp (/ ln 3))
                (define A p1)
                (define Ax (posn-x p1))
                (define Ay (posn-y p1))
                (define B (make-posn (+ Ax lp) Ay))
                (define C (make-posn (+ Ax lp) (- Ay lp)))
                (define D (make-posn (+ Ax (* 2 lp)) (- Ay lp)))
                (define E (make-posn (+ Ax (* 2 lp)) Ay))
                (define F p2)]
          (vkline A B
                  (simple-line B C
                               (vkline C D
                                       (simple-line D E
                                                    (vkline E F img)))))))))


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
