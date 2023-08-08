;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname water-balloon-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-p9)
(@cwl ???)

(@problem 1)
;; In this problem, we will design an animation of throwing a water balloon.  
;; When the program starts the water balloon should appear on the left side 
;; of the screen, half-way up.  Since the balloon was thrown, it should 
;; fly across the screen, rotating in a clockwise fashion. Pressing the 
;; space key should cause the program to start over with the water balloon
;; back at the left side of the screen. 
;;
;; NOTE: Please include your domain analysis at the top in a comment box. 
;;
;; The following links lead to images that can assist you with your domain
;; analysis:
;; 
;; 1) https://cs110.students.cs.ubc.ca/bank/wb1.png
;;
;; 2) https://cs110.students.cs.ubc.ca/bank/wb2.png
;; 
;; 3) https://cs110.students.cs.ubc.ca/bank/wb3.png
;; 
;; 4) https://cs110.students.cs.ubc.ca/bank/wb4.png
;;
;;
;; Here is an image of the water balloon:
;;
;; (define WATER-BALLOON
;;   (bitmap/url
;;    "https://cs110.students.cs.ubc.ca/bank/water-balloon.png"))
;;  
;; NOTE: The rotate function wants an angle in degrees as its first 
;; argument. By that it means Number[0, 360). As time goes by your balloon 
;; may end up spinning more than once, for example, you may get to a point 
;; where it has spun 362 degrees, which rotate won't accept. 
;;
;; The solution to that is to use the modulo function as follows:
;;
;; (rotate (modulo ... 360) (text "hello" 30 "black"))
;;
;; where ... should be replaced by the number of degrees to rotate.
;;
;; NOTE: It is possible to design this program with simple atomic data, 
;; but we would like you to use compound data.


;; Spinning water balloon

(@htdw BalloonState)

;; =================

;; Constants

(define WIDTH  600)
(define HEIGHT 300)

(define CTR-Y (/ HEIGHT 2))

(define LINEAR-SPEED 2)  
(define ANGULAR-SPEED 3) ;optional

(define MTS (rectangle WIDTH HEIGHT "solid" "white"))

(define WATER-BALLOON
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/water-balloon.png"))


 
;; =================
;; Data Definitions

(@htdd BalloonState)
(define-struct bs (x a))
;; BalloonState is (make-bs Number Number)
;; interp. The state of a tossed balloon.
;;         x is the x-coordinate in pixels
;;         a is the angle of rotation in degrees
(define BS1 (make-bs 10 0))
(define BS2 (make-bs 30 15))

(@dd-template-rules compound) ;2 fields

#;
(define (fn-for-balloon-state bs)
  (... (bs-x bs)                  ;Number 
       (bs-a bs)))                ;Number



;; =================
;; Functions

(@htdf main)
(@signature BalloonState -> BalloonState)
;; start the world with (main (make-bs 0 0))
;; no tests for main function

(@template-origin htdw-main)

(define (main bs)
  (big-bang bs                   ; BalloonState
    (on-tick next-bs)    ; BalloonState -> BalloonState
    (to-draw render-bs)  ; BalloonState -> Image
    (on-key  reset-bs))) ; BalloonState KeyEvent -> BalloonState


(@htdf next-bs)
(@signature BalloonState -> BalloonState)
;; advance bs by LINEAR-SPEED and ANGULAR-SPEED
(check-expect (next-bs (make-bs 1 12))
              (make-bs (+ 1 LINEAR-SPEED) (- 12 ANGULAR-SPEED)))

;(define (next-bs bs) bs)  ;stub

(@template-origin BalloonState)

(@template
 (define (next-bs bs)
   (... (bs-x bs)
        (bs-a bs))))

(define (next-bs bs)
  (make-bs (+ (bs-x bs) LINEAR-SPEED)
           (- (bs-a bs) ANGULAR-SPEED)))


(@htdf render-bs)
(@signature BalloonState -> Image)
;; produces the bs at height bs-x rotated (remainder bs-a 360) on the MTS
(check-expect (render-bs (make-bs 1 12))
              (place-image (rotate 12 WATER-BALLOON)
                           1
                           CTR-Y
                           MTS))
(check-expect (render-bs (make-bs 10 361))
              (place-image (rotate 1 WATER-BALLOON)
                           10
                           CTR-Y
                           MTS))

; (define (render-bs bs) MTS) ;stub

(@template-origin BalloonState)

(@template
 (define (render-bs bs)
   (... (bs-x bs)
        (bs-a bs))))

(define (render-bs bs)
  (place-image (rotate (modulo (bs-a bs) 360) WATER-BALLOON)
               (bs-x bs)
               CTR-Y
               MTS))


(@htdf reset-bs)
(@signature BalloonState KeyEvent -> BalloonState)
;; when space bar is pressed, resets balloon to left side of screen, unrotated
(check-expect (reset-bs (make-bs 1 12) " ")
              (make-bs 0 0))
(check-expect (reset-bs (make-bs 1 12) "left")
              (make-bs 1 12))

; (define (reset-bs bs ke) bs) ;stub

(@template-origin KeyEvent)

(@template   
 (define (reset-bs bs ke)
   (cond [(key=? ke " ") (... bs)]
         [else 
          (... bs)])))

(define (reset-bs bs ke)
  (cond [(key=? " " ke) (make-bs 0 0)]
        [else bs]))
