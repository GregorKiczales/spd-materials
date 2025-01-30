;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname m03-spider-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment lectures/m03-spider)

(@cwl ???) ;replace ??? with your cwl


(@problem 1)
#|
PROBLEM:

Design a world program in which a spider starts at the top of the screen
and slowly drops down it. The spider should stop when it reaches the bottom
of the screen.

You can improve your spider by re-running the HtDW recipe to add these
features. 


  - Draw a line from the top of the screen to the spider, this is the thread 
    it is hanging from. You will need to use add-line for this. Look in the
    DrRacket help desk to see how add-line works.  [NOTE that adding this
    functionality will cause the autograder to complain, the autograder is
    just designed to grade the original problem.]
    
  - Arrange for pressing the space key to reset the spider to the top of 
    the screen.
|#



;; My world program  (make this more specific)

(@htdw WS)

;; =================
;; Constants:


;; =================
;; Data definitions:

(@htdd WS)
;; WS is ... (give WS a better name)








;; =================
;; Functions:

(@htdf main)
(@signature WS -> WS)
;; start the world with ...
;; no tests for main functions

(@template-origin htdw-main)

(define (main ws)
  (big-bang ws           ; WS
    (on-tick   tock)     ; WS -> WS
    (to-draw   render)   ; WS -> Image
    (stop-when ...)      ; WS -> Boolean
    (on-mouse  ...)      ; WS Integer Integer MouseEvent -> WS
    (on-key    ...)))    ; WS KeyEvent -> WS



(@htdf tock)
(@signature WS -> WS)
;; produce the next ...
;; !!!
(define (tock ws) ...)











(@htdf render)
(@signature WS -> Image)
;; render ... 
;; !!!
(define (render ws) ...)
