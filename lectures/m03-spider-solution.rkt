;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m03-spider-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment lectures/m03-spider)

(@problem 1)
#|

Design a world program in which a spider starts at the top of the screen
and slowly drops down it. The spider should stop when it reaches the bottom
of the screen.

You can improve your spider by re-running the HtDW recipe to add these
features. 


  - Draw a line from the top of the screen to the spider, this is the thread 
    it is hanging from. You will need to use add-line for this. Look in the
    DrRacket help desk to see how add-line works.
    
  - Arrange for pressing the space key to reset the spider to the top of 
    the screen.
|#



;; My creepy crawly spider

(@htdw Spider)

;; =================
;; Constants:

(define WIDTH  400) ;pixels
(define HEIGHT 600)

(define CTR-X (/ WIDTH 2))

(define SPIDER-RADIUS 10)

(define TOP (+      0   SPIDER-RADIUS))
(define BOT (- HEIGHT 1 SPIDER-RADIUS))

(define SPIDER-IMAGE (circle SPIDER-RADIUS "solid" "black"))


(define SPEED 2) ; pixels per tick

(define MTS (empty-scene WIDTH HEIGHT))


;; =================
;; Data definitions:

(@htdd Spider)
;; Spider is Number
;; interp. y coordinate of the spider
;;         distance of the centre of the spider from top
;; CONSTRAINT: to be entirely visible, must be in [TOP, BOT]
;; TOP, BOT defined above
(define MID (/ HEIGHT 2))

(@dd-template-rules atomic-non-distinct)

(define (fn-for-spider s)
  (... s))

;; =================
;; Functions:



(@htdf main)
(@signature Spider -> Spider)
;; start the world with (main TOP)

(@template-origin htdw-main)

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
;; produce next spider moving down by SPEED (s + SPEED), stopping at bottom
(check-expect (tock TOP) (+ TOP SPEED))
(check-expect (tock (- BOT SPEED  1)) (- BOT 1)) ;above BOT - SPEED
(check-expect (tock (- BOT SPEED  0))    BOT)    ;at    BOT - SPEED
(check-expect (tock (- BOT SPEED -1))    BOT)    ;below BOT - SPEED

;(define (tock s) s) ;stub

(@template-origin Spider)

(@template
 (define (tock s)
   (... s)))

(define (tock s)
  (if (>= (+ s SPEED) BOT)
      BOT
      (+ s SPEED)))


(@htdf render)
(@signature Spider -> Image)
;; place SPIDER-IMG on MTS at its proper x and y 
(check-expect (render TOP) (place-image SPIDER-IMAGE CTR-X TOP MTS))
(check-expect (render (/ HEIGHT 2))
              (place-image SPIDER-IMAGE CTR-X (/ HEIGHT 2) MTS))

;(define (render s) MTS) ;stub

(@template-origin Spider)

(@template
 (define (render s)
   (... s)))

(define (render s)
  (place-image SPIDER-IMAGE CTR-X s MTS))
