;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cat-v4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/htdw-l2)
(@cwl ???)

(@problem 1)
;; Below is a world program in which a cat walks across the screen
;; from left to right. Pressing the space key resets the cat to the
;; left edge of the screen.
;;
;; Revise this program so that when the mouse is clicked in the window 
;; the cat moves to the mouse's current x position. You will need to
;; consult the DrRacket help desk to learn about the four arguments to
;; big-bang on-mouse handlers.


;; A cat that walks from left to right across the screen.

(@htdw Cat)

;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 400)

(define CTR-Y (/ HEIGHT 2))

(define SPEED 3)

(define MTS (empty-scene WIDTH HEIGHT))

(define CAT-IMG
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/cat-img.png"))



;; =================
;; Data definitions:

(@htdd Cat)
;; Cat is Number
;; interp. x position of the cat in screen coordinates
(define C1 0)           ;left edge
(define C2 (/ WIDTH 2)) ;middle
(define C3 WIDTH)       ;right edge

(@dd-template-rules atomic-non-distinct) ;Number

#;
(define (fn-for-cat c)
  (... c))



;; =================
;; Functions:

(@htdf main)
(@signature Cat -> Cat)
;; start the world with (main 0)

(@template-origin htdw-main)

(define (main c)
  (big-bang c                  ; Cat
    (on-tick   advance-cat)    ; Cat -> Cat
    (to-draw   render)         ; Cat -> Image
    (on-key    handle-key)     ; Cat KeyEvent -> Cat
    (on-mouse  handle-mouse))) ; Cat Integer Integer MouseEvent -> Cat


(@htdf advance-cat)
(@signature Cat -> Cat)
;; produce the next cat, by advancing it SPEED pixel(s) to right
(check-expect (advance-cat 3) (+ 3 SPEED))

;(define (advance-cat c) 0) ;stub

(@template-origin Cat)

(@template
 (define (advance-cat c)
   (... c)))

(define (advance-cat c)
  (+ c SPEED)) 


(@htdf render)
(@signature Cat -> Image)
;; render the cat image at appropriate place on MTS 
(check-expect (render 4) (place-image CAT-IMG 4 CTR-Y MTS))  
              
;(define (render c) MTS) ;stub

(@template-origin Cat)

(@template
 (define (render c)
   (... c)))

(define (render c)
  (place-image CAT-IMG c CTR-Y MTS)) 


(@htdf handle-key)
(@signature Cat KeyEvent -> Cat)
;; reset cat to left edge when space key is pressed
(check-expect (handle-key 10 " ")  0)
(check-expect (handle-key 10 "a") 10)
(check-expect (handle-key  0 " ")  0)
(check-expect (handle-key  0 "a")  0)

;(define (handle-key c ke) 0) ;stub

(@template-origin KeyEvent)

(@template   
 (define (handle-key c ke)
   (cond [(key=? ke " ") (... c)]
         [else 
          (... c)])))

(define (handle-key c ke)
  (cond [(key=? ke " ") 0]
        [else c]))


(@htdf handle-mouse)
(@signature Cat Integer Integer MouseEvent -> Cat)
;; move cat to mouse's x-coordinate
(check-expect (handle-mouse 0 0 0 "button-down") 0)
(check-expect (handle-mouse 10 0 0 "button-down") 0)
(check-expect (handle-mouse 0 10 0 "button-down") 10)
(check-expect (handle-mouse 0 0 10 "button-down") 0)
(check-expect (handle-mouse 0 10 0 "button-up") 0)
(check-expect (handle-mouse 10 100 20 "button-down") 100)
(check-expect (handle-mouse 10 600 20 "button-down") 600)
(check-expect (handle-mouse 600 100 20 "button-down") 100)

;(define (handle-mouse c x y me) 0) ;stub

(@template-origin MouseEvent)

(@template
 (define (handle-mouse c x y me)
   (cond [(mouse=? me "button-down") (... c x y)]
         [else
          (... c x y)])))

(define (handle-mouse c x y me)
  (cond [(mouse=? me "button-down") x]
        [else c]))
