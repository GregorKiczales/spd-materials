;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m03-compound-spider-v1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(require 2htdp/image)
(require 2htdp/universe)

(@assignment lectures/m03-compound-spider)

(@cwl ???) ;replace ??? with your cwl

;; Spider, goes down the screen with thread

#|
PROBLEM:

Revise this program so that when the program starts the spider moves down the 
screen, but pressing the space key changes its direction. It should also change
direction when it hits the top or bottom edge.

 - First "reverse-engineer" the domain analysis from the program.
 - Then revise the domain analysis for this new behaviour.
 - Then systematically work your way through the program in the same
   order as HtDW says revising the program to match the new analysis.

   You will need to CHANGE the definition of the Spider type

   When you change a type (a data definition) you need to systematically
   go check on every function that consumes or produces that type to update
   it to the new definition.

Then you can extend the program to make the spider appear to wiggle as it
moves. Unlike in Cowabunga you should represent the state of the wiggle
explicitly as a field in the world state.
|#



;; My creepy crawly spider

(@htdw Spider)

;; =================
;; Constants:

(define WIDTH 400)
(define HEIGHT 600)

(define CTR-X (/ WIDTH 2))

(define SPEED 2) ;pixels per tick

(define SPIDER-RADIUS 10)

(define TOP (+ 0        SPIDER-RADIUS)) ;to be entirely visible
(define BOT (- HEIGHT 1 SPIDER-RADIUS)) ;center has to be in [TOP, BOT]

(define MID (/ HEIGHT 2))


(define SPIDER-IMAGE (circle SPIDER-RADIUS "solid" "black"))

(define MTS (empty-scene WIDTH HEIGHT))


;; =================
;; Data definitions:
(@problem 1)
(@htdd Spider)
(define-struct spider (y dy))
;; Spider is (make-spider Number Number)
;; interp. y is spider's vertical position in screen coordinates (pixels)
;;         dy is velocity in pixels per tick, + is down, - is up
;; CONSTRAINT: to be visible, must be in
;;             [TOP, BOT] which is [SPIDER-RADIUS, HEIGHT - 1 - SPIDER-RADIUS]
(define S-TOP-D (make-spider TOP  3))   ;top going down
(define S-MID-D (make-spider MID  2))   ;middle going down
(define S-MID-U (make-spider MID -3))   ;middle going up
(define S-BOT-U (make-spider BOT -3))   ;bottom going up

#;#; ;!!! OLD DELETE WHEN DONE
(@dd-template-rules atomic-non-distinct)

(define (fn-for-spider s)
  (... s))

(@dd-template-rules compound);2 fields

(define (fn-for-spider s)
  (... (spider-y s)
       (spider-dy s)))

;; =================
;; Functions:

(@htdf main)
(@signature Spider -> Spider)
;; start the world with (main TOP)
;; no tests for htdw-main template

(@template-origin htdw-main)

;; no @template for htdw-main template

(define (main s)
  (big-bang s             ; Spider
    (on-tick   tock)      ; Spider -> Spider
    (to-draw   render)    ; Spider -> Image
    ;(stop-when ...)      ; Spider -> Boolean
    ;(on-mouse  ...)      ; Spider Integer Integer MouseEvent -> Spider
    ;(on-key    ...)      ; Spider KeyEvent -> Spider
    ))


(@htdf tock)
(@signature Spider -> Spider)
;; move spider by dy, except change direction at bottom and top edges

;; top edge: doesn't touch TOP, just touches TOP, tries to go past TOP
(check-expect (tock (make-spider (+ TOP 3) -2)) (make-spider (+ TOP 1) -2))
(check-expect (tock (make-spider (+ TOP 3) -3)) (make-spider    TOP     3))
(check-expect (tock (make-spider (+ TOP 3) -4)) (make-spider    TOP     4))

;; bottom edge: doesn't touch BOT, just touches BOT, tries to go past BOT
(check-expect (tock (make-spider (- BOT 3) 2))  (make-spider (- BOT 1)  2))
(check-expect (tock (make-spider (- BOT 3) 3))  (make-spider    BOT    -3))
(check-expect (tock (make-spider (- BOT 3) 4))  (make-spider    BOT    -4))

;(define (tock s) s) ;stub

(@template-origin Spider)

(@template
 (define (tock s)
   (... (spider-y s)
        (spider-dy s))))

(define (tock s)
  (cond [(<= (+ (spider-y s) (spider-dy s)) TOP)
         (make-spider TOP (- (spider-dy s)))]
        [(>= (+ (spider-y s) (spider-dy s)) BOT)
         (make-spider BOT (- (spider-dy s)))]
        [else
         (make-spider (+ (spider-y s) (spider-dy s))
                      (spider-dy s))]))






























(@htdf render)
(@signature Spider -> Image)
;; place SPIDER-IMAGE and thread image on MTS
(check-expect (render 21)
              (add-line (place-image SPIDER-IMAGE CTR-X 21 MTS)
                        CTR-X 0
                        CTR-X 21
                        "black"))

(check-expect (render 36)
              (add-line (place-image SPIDER-IMAGE CTR-X 36 MTS)
                        CTR-X 0
                        CTR-X 36
                        "black"))

;(define (render s) MTS)

(@template-origin Spider)

(@template
 (define (render s)
   (... s)))

(define (render s)
  (add-line (place-image SPIDER-IMAGE
                         CTR-X
                         s
                         MTS)
            CTR-X 0
            CTR-X s
            "black"))
