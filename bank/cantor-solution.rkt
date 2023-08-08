;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname cantor-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/genrec-p3)
(@cwl ???)

(@problem 1)
;; A Cantor Set is another fractal with a nice simple geometry.
;; The idea of a Cantor set is to have a bar (or rectangle) of
;; a certain width w, then below that are two recursive calls each
;; of 1/3 the width, separated by a whitespace of 1/3 the width.
;;
;; So this means that the
;;   width of the whitespace   wc  is  (/ w 3)
;;   width of recursive calls  wr  is  (/ (- w wc) 2)
;;  
;; To make it look better a little extra whitespace is put between
;; the bars.
;;
;; Here are a couple of examples (assuming a reasonable CUTOFF)
;;
;; (cantor CUTOFF) produces:
;;
;; https://cs110.students.cs.ubc.ca/bank/cantor1.png
;;
;; (cantor (* CUTOFF 3)) produces:
;;
;; https://cs110.students.cs.ubc.ca/bank/cantor2.png
;;
;; And that keeps building up to something like the following. So
;; as it goes it gets wider and taller of course.
;;
;; https://cs110.students.cs.ubc.ca/bank/cantor3.png
;;
;; PROBLEM A:
;;
;; Design a function that consumes a width and produces a cantor set of 
;; the given width.
;;
;;
;; PROBLEM B:
;;
;; Add a second parameter to your function that controls the percentage 
;; of the recursive call that is white each time. Calling your new function
;; with a second argument of 1/3 would produce the same images as the old 
;; function.
;;
;; PROBLEM C:
;;
;; Now you can make a fun world program that works this way:
;;   The world state should simply be the most recent x coordinate of the mouse.
;;  
;;   The to-draw handler should just call your new cantor function with the
;;   width of your MTS as its first argument and the last x coordinate of
;;   the mouse divided by that width as its second argument.
  

;; A world program for running a cantor set
;; The mouse position controls parameters of the fractal.

(@htdw WorldState)

;; =================
;; Constants:

(define WIDTH  400)
(define HEIGHT 600)

(define CUTOFF 4) 
(define BAR-HEIGHT 20)
(define SPACING-HEIGHT (/ BAR-HEIGHT 2))



;; =================
;; Data definitions:

;; In a more elaborate version of the program the world state
;; could be the last x, y position of the mouse, something like:
;; ;; WorldState is (make-posn Number Number)
;; ;; interp. last x and y coordinate of mouse

(@htdd WorldState)
;; WorldState is Number
;; interp. the last x-coordinate of the mouse 
(define WS1 100)
(define WS2 4)
#;
(define (fn-for-ws ws)
  (... ws))



;; =================
;; Functions:

(@htdf main)
(@signature WorldState -> WorldState)
;; run the interactive cantor set generator; call with (main 0)
;; <no tests for main function>

(@template-origin htdw-main)

(define (main ws)
  (big-bang ws                        ; WorldState
            (on-draw render)          ; WorldState -> Image
            (on-mouse handle-mouse))) ; WorldState Integer Integer MouseEvent
                                      ;  -> WorldState


(@htdf render)
(@signature WorldState -> Image)
;; render cantor set based on current mouse position
(check-expect (render 100) (cantor WIDTH (/ 100 WIDTH)))
(check-expect (render 300) (cantor WIDTH (/ 300 WIDTH)))

(@template-origin Number)

(define (render ws)
  (cantor WIDTH (/ ws WIDTH)))


(@htdf handle-mouse)
(@signature WorldState Integer Integer MouseEvent -> WorldState)
;; update the current ws according to mouse position
(check-expect (handle-mouse 0   0 10 "move") 0)
(check-expect (handle-mouse 100 0 10 "move") 0)
(check-expect (handle-mouse  20 0 10 "button-down") 20)

(@template-origin MouseEvent)

(define (handle-mouse ws x y mevt)
  (cond [(mouse=? mevt "move") x]
        [else ws]))


(@htdf cantor)
(@signature Number Number -> Image)
;; render cantor set, of given width and ration of center bar in 2nd row
(check-expect (cantor 0 .5)
              (rectangle 0 BAR-HEIGHT "solid" "blue"))

(check-expect (cantor 32 0)
              (above (rectangle 32 BAR-HEIGHT "solid" "blue")
                     (rectangle 32 SPACING-HEIGHT "solid" "white")
                     (rectangle 32 BAR-HEIGHT "solid" "blue")
                     (rectangle 32 SPACING-HEIGHT "solid" "white")
                     (rectangle 32 BAR-HEIGHT "solid" "blue")
                     (rectangle 32 SPACING-HEIGHT "solid" "white")
                     (rectangle 32 BAR-HEIGHT "solid" "blue")))

(check-expect (cantor 32 1)
              (above (rectangle 32 BAR-HEIGHT "solid" "blue")
                     (rectangle 32 SPACING-HEIGHT "solid" "white")
                     (rectangle 32 BAR-HEIGHT "solid" "white")))

(check-expect (cantor 32 .5)
              (above (rectangle 32 BAR-HEIGHT "solid" "blue")
                     (rectangle 32 SPACING-HEIGHT "solid" "white")
                     (beside 
                      (above (rectangle 8 BAR-HEIGHT "solid" "blue")
                             (rectangle 8 SPACING-HEIGHT "solid" "white")
                             (beside 
                              (rectangle 2 BAR-HEIGHT "solid" "blue")
                              (rectangle 4 BAR-HEIGHT "solid" "white")
                              (rectangle 2 BAR-HEIGHT "solid" "blue")))
                      (rectangle 16 BAR-HEIGHT "solid" "white")
                      (above (rectangle 8 BAR-HEIGHT "solid" "blue")
                             (rectangle 8 SPACING-HEIGHT "solid" "white")
                             (beside 
                              (rectangle 2 BAR-HEIGHT "solid" "blue")
                              (rectangle 4 BAR-HEIGHT "solid" "white")
                              (rectangle 2 BAR-HEIGHT "solid" "blue"))))))


;; Termination Argument:
;;   trivial case: w <= CUTOFF
;;   reduction step: (/ (- w (* r w)) 2)
;;   argument: as long as CUTOFF is > 0, and 0 <= r <= 1, repeatedly
;;   multiplying w by r (the reduction step) will reduce w to eventually reach
;;   the base case.


(@template-origin genrec)

(define (cantor w r)
  (if (<= w CUTOFF)
      (rectangle w BAR-HEIGHT "solid" "blue")      
      (local [(define wc  (* w r))            ;width of center white band
              (define ws  (/ (- w wc) 2))     ;width of side blue bands
              (define ctr (rectangle wc BAR-HEIGHT "solid" "white"))
              (define l/r (cantor ws r))]
        (above (rectangle w BAR-HEIGHT "solid" "blue")
               (rectangle w SPACING-HEIGHT   "solid" "white")
               (beside l/r ctr l/r))))) 
