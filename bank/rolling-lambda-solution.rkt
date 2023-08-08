;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rolling-lambda-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-p7)
(@cwl ???)

(@problem 1)
;; Design a world program as follows:
;; 
;; The world starts off with a lambda on the left hand side of the screen. As 
;; time passes, the lambda will roll towards the right hand side of the screen. 
;; Clicking the mouse changes the direction the lambda is rolling (ie from 
;; left -> right to right -> left). If the lambda hits the side of the window 
;; it should also change direction.
;;
;; Starting display (rolling to the right):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda1.png
;;
;; After a few seconds (rolling to the right):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda2.png
;;
;; After a few more seconds (rolling to the right):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda3.png
;;
;; A few seconds after clicking the mouse (rolling to the left):
;;
;; https://cs110.students.cs.ubc.ca/bank/lambda4.png
;; 
;; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
;; analysis before starting to work on the code file.
;;
;; NOTE 2: DO THIS PROBLEM IN STAGES.
;;
;; FIRST
;;
;; Just make the lambda slide back and forth across the screen without rolling.
;;      
;; SECOND
;;  
;; Make the lambda spin as it slides, but don't worry about making the spinning
;; be just exactly right to make it look like its rolling. Just have it 
;; spinning and sliding back and forth across the screen.
;;
;; FINALLY
;;
;; Work out the math you need to in order to make the lambda look like it is
;; actually rolling.  Remember that the circumference of a circle is
;; 2*pi*radius, so that for each degree of rotation the circle needs to move:
;;
;;    2*pi*radius
;;    -----------
;;        360
;;
;; Also note that the rotate function requires an angle in degrees as its 
;; first argument. [By that it means Number[0, 360). As time goes by the lambda
;; may end up spinning more than once, for example, you may get to a point 
;; where it has spun 362 degrees, which rotate won't accept. One solution to 
;;that is to  use the modulo function as follows:
;;
;; (rotate (modulo ... 360) LAMBDA)
;;
;; where ... can be an expression that produces any positive number of degrees 
;; and remainder will produce a number in [0, 360).
;;
;; Remember that you can lookup the documentation of modulo if you need to know 
;; more about it.


;; A lambda that rolls back and forth across screen.

(@htdw LambdaState)

;; =================
;; Constants:

(define LAMBDA
  (bitmap/url
   "https://cs110.students.cs.ubc.ca/bank/lambda.png"))

(define ALMOST-PI 3.14159)  ;we use ALMOST-PI instead of pi because if we 
;                           ;use pi then we end up having to use check-within
;                           ;in all the tests

(define RADIUS (/ (image-height LAMBDA) 2))  

(define CIRCUMFERENCE (* 2 ALMOST-PI RADIUS))



;; This is how far a circle moves in the x direction for each
;; degree of angle it turns.
(define X-MOVE-PER-DEGREE (/ CIRCUMFERENCE 360))

;; Change per clock tick in degrees and x position.
(define ANGULAR-SPEED -2)
(define       X-SPEED (* -1 ANGULAR-SPEED X-MOVE-PER-DEGREE))

(define WIDTH  (+ CIRCUMFERENCE (* 2 RADIUS)))
(define HEIGHT (* RADIUS 3))

(define YPOS (* RADIUS 2))

(define MTS (empty-scene WIDTH HEIGHT))



;; =================
;; Data definitions:

(@htdd LambdaState)
(define-struct ls (d x t))
;; LambdaState is (make-ls Integer Number Number]
;; interp. d is the direction lambda is moving, -1 means to left,
;;         +1 means to right
;;         x is screen coordinate of center of lambda, restricted to [0, WIDTH]
;;         t is angular rotation of lambda in degrees, restricted to [0, 360)
(define LS1 (make-ls 1 5 100))
(define LS2 (make-ls -1 10 50))

(@dd-template-rules compound) ;3 fields

#;
(define (fn-for-lambda-state ls)
  (... (ls-d ls)                 ;Integer  
       (ls-x ls)                 ;Number
       (ls-t ls)))               ;Number



;; =================
;; Functions:

(@htdf main)
(@signature LambdaState -> LambdaState)
;; start the world with (main (make-ls 1 RADIUS 359))
;; no tests for main function

(@template-origin htdw-main)

(define (main ls)
  (big-bang ls              ; LambdaState
    (state true)
    (on-tick tock)          ; LambdaState -> LambdaState
    (to-draw render)        ; LambdaState -> Image
    (on-mouse change-dir))) ; LambdaState Integer Integer
; MouseEvent -> LambdaState


(@htdf tock)
(@signature LambdaState -> LambdaState)
;; roll the lambda in direction ls-d
(check-expect (tock (make-ls 1 60 100)) 
              (make-ls 1 
                       (+  60 X-SPEED)
                       (+ 100 ANGULAR-SPEED)))

(check-expect (tock (make-ls 1 (- WIDTH RADIUS) 1)) 
              (make-ls -1
                       (- WIDTH RADIUS)
                       1))

(check-expect (tock (make-ls -1 0 359)) 
              (make-ls 1
                       RADIUS
                       359))

;(define (tock ls) LS1)

(@template-origin LambdaState)

(@template
 (define (tock ls)
   (... (ls-d ls) 
        (ls-x ls)
        (ls-t ls))))

(define (tock ls)
  (cond [(>= (+ (ls-x ls) (* (ls-d ls) X-SPEED)) (- WIDTH RADIUS)) ;right edge
         (make-ls -1 (- WIDTH RADIUS) 1)]
        [(<= (+ (ls-x ls) (* (ls-d ls) X-SPEED))          RADIUS)  ;left edge
         (make-ls 1 RADIUS 359)]
        [else
         (make-ls (ls-d ls)
                  (+ (ls-x ls) (*    (ls-d ls) X-SPEED))
                  (modulo (+ (ls-t ls) (* (ls-d ls) ANGULAR-SPEED)) 359))]))


(@htdf render)
(@signature LambdaState -> Image)
;; place the lambda at ls-x, with angle ls-t
(check-expect (render LS1)
              (place-image (rotate (ls-t LS1) LAMBDA)
                           (ls-x LS1)
                           YPOS
                           MTS))

;(define (render ls) LAMBDA)

(@template-origin LambdaState)

(@template
 (define (render ls)
   (... (ls-d ls) 
        (ls-x ls)
        (ls-t ls))))

(define (render ls)
  (place-image (rotate (ls-t ls) LAMBDA)
               (ls-x ls)
               YPOS
               MTS))


(@htdf change-dir)
(@signature LambdaState Integer Integer MouseEvent -> LambdaState)
;; reverse ls-d
(check-expect (change-dir LS1  0  0 "button-down") (make-ls -1  5 100))
(check-expect (change-dir LS2 10 20 "button-down") (make-ls  1 10  50))

;(define (change-dir x y ls me) LS1)

(@template-origin MouseEvent)

(@template
 (define (handle-mouse ls x y me)
   (cond [(mouse=? me "button-down") (... ls x y)]
         [else
          (... ls x y)])))

(define (change-dir ls x y me)
  (cond [(mouse=? "button-down" me)
         (make-ls (* -1 (ls-d ls))
                  (ls-x ls)
                  (ls-t ls))]
        [else ls]))
