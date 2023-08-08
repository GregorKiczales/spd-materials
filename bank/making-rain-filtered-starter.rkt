;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname making-rain-filtered-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment bank/helpers-p2)
(@cwl ???)

(@problem 1)
;; Design a simple interactive animation of rain falling down a screen. Wherever
;; we click, a rain drop should be created and as time goes by it should fall.
;; Over time the drops will reach the bottom of the screen and "fall off".
;; You should filter these excess drops out of the world state - otherwise
;; your program is continuing to tick and draw them long after they are
;; invisible.
;;
;; In your design pay particular attention to the helper rules. In our solution
;; we use these rules to split out helpers:
;;   - function composition
;;   - reference
;;   - knowledge domain shift
;;
;; NOTE: This is a fairly long problem.  While you should be getting more
;; comfortable with world problems there is still a fair amount of work to do 
;; here. Our solution has 9 functions including main. If you find it is taking
;; you too long then jump ahead to the next homework problem and finish this
;; later.


;; Make it rain where we want it to.

(@htdw ListOfDrop)

;; =================
;; Constants:

(define WIDTH  300)
(define HEIGHT 300)

(define SPEED 1)

(define DROP (ellipse 4 8 "solid" "blue"))

(define MTS (rectangle WIDTH HEIGHT "solid" "light blue"))



;; =================
;; Data definitions:

(@htdd Drop)
(define-struct drop (x y))
;; Drop is (make-drop Integer Integer)
;; interp. a raindrop on the screen, with x and y coordinates in pixels.
(define D1 (make-drop 10 30))

(@dd-template-rules compound) ;2 fields

#;
(define (fn-for-drop d)
  (... (drop-x d)       ;Integer
       (drop-y d)))     ;Integer


(@htdd ListOfDrop)
;; ListOfDrop is one of:
;;  - empty
;;  - (cons Drop ListOfDrop)
;; interp. a list of drops
(define LOD1 empty)
(define LOD2 (cons (make-drop 10 20) (cons (make-drop 3 6) empty)))

(@dd-template-rules one-of             ;2 cases
                    atomic-distinct    ;empty
                    compound           ;(cons Drop ListOfDrop)
                    ref                ;(first lod) is Drop
                    self-ref)          ;(rest lod) is ListOfDrop

#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-drop (first lod))
              (fn-for-lod (rest lod)))]))



;; =================
;; Functions:

(@htdf main)
(@signature ListOfDrop -> ListOfDrop)
;; start rain program by evaluating (main empty)

(@template-origin htdw-main)

(define (main lod0)
  (big-bang lod0                      ; ListOfDrop
            (on-mouse handle-mouse)   ; ListOfDrop Integer Integer
                                      ; MouseEvent -> ListOfDrop
            (on-tick  next-drops)     ; ListOfDrop -> ListOfDrop
            (to-draw  render-drops))) ; ListOfDrop -> Image


(@htdf handle-mouse)
(@signature ListOfDrop Integer Integer MouseEvent -> ListOfDrop)
;; if mevt is "button-down" add a new drop at that position
;; !!!
(define (handle-mouse lod x y mevt) empty) ;stub


(@htdf next-drops)
(@signature ListOfDrop -> ListOfDrop)
;; produce filtered and ticked list of drops
;; !!!
(define (next-drops lod) empty) ;stub


(@htdf render-drops)
(@signature ListOfDrop -> Image)
;; render the drops onto MTS
;; !!!
(define (render-drops lod) MTS) ;stub
