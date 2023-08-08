;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tracker-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/compound-p6)
(@cwl ???)

(@problem 1)
;; Design a world program that displays the current (x, y) position
;; of the mouse at that current position. So as the mouse moves the 
;; numbers in the (x, y) display changes and its position changes. 


;; Display the current mouse position, at the mouse position.

(@htdw Position)

;; =================
;; Constants:

(define WIDTH  400)
(define HEIGHT 400)

(define TEXT-SIZE 20)
(define TEXT-COLOR "black")

(define MTS (empty-scene WIDTH HEIGHT))



;; =================
;; Data definitions:

(@htdd Position)
(define-struct position (x y))
;; Position is (make-position Integer Integer)
;; interp. position of mouse in pixels
;;
(define P1 (make-position 0 0))          ;upper left
(define P2 (make-position WIDTH HEIGHT)) ;lower right

(@dd-template-rules compound) ;2 fields

#;
(define (fn-for-position p)
  (... (position-x p)   ;Integer
       (position-y p))) ;Integer



;; =================
;; Functions:

(@htdf main)
(@signature Position -> Position)
;; called to start the mouse tracker, call with (main (make-position 0 0))
;; no tests for main function

(@template-origin htdw-main)

(define (main p)
  (big-bang p
    (to-draw  render)         ; Position -> Image
    (on-mouse handle-mouse))) ; Position Integer Integer MouseEvent -> Position


(@htdf render)
(@signature Position -> Image)
;; render current position at the position itself
(check-expect (render (make-position 110 33))
              (place-image (text "(110, 33)" TEXT-SIZE TEXT-COLOR) 110 33 MTS))

;(define (render c) MTS)  ;stub

(@template-origin Position)

(@template
 (define (render p)
   (... (position-x p)
        (position-y p))))

(define (render p)  
  (place-image (text (string-append "(" 
                                    (number->string (position-x p))
                                    ", " 
                                    (number->string (position-y p))
                                    ")")
                     TEXT-SIZE
                     TEXT-COLOR)
               (position-x p)
               (position-y p)
               MTS))


(@htdf handle-mouse)
(@signature Position Integer Integer MouseEvent -> Position)
;; changes current position world state to current mouse position
(check-expect (handle-mouse (make-position 20 30) 3 4 "button-down")
              (make-position 20 30))
(check-expect (handle-mouse (make-position 20 30) 3 4 "move")
              (make-position  3  4))

;(define (handle-mouse p x y me) p) ;stub

(@template-origin MouseEvent)

(@template
 (define (handle-mouse p x y me)
   (cond [(mouse=? me "button-down") (... p x y)]
         [else
          (... p x y)])))

(define (handle-mouse p x y me)
  (cond [(mouse=? me "move") (make-position x y)]
        [else p]))




