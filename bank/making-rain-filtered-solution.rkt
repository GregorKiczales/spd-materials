;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname making-rain-filtered-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
  (big-bang lod0              ; ListOfDrop
    (on-mouse handle-mouse)   ; ListOfDrop Integer Integer
    ;;                        ; MouseEvent -> ListOfDrop
    (on-tick  next-drops)     ; ListOfDrop -> ListOfDrop
    (to-draw  render-drops))) ; ListOfDrop -> Image


(@htdf handle-mouse)
(@signature ListOfDrop Integer Integer MouseEvent -> ListOfDrop)
;; if mevt is "button-down" add a new drop at that position
(check-expect (handle-mouse empty 3 12 "button-down")
              (cons (make-drop 3 12) empty))
(check-expect (handle-mouse empty 3 12 "drag")
              empty)

(@template-origin MouseEvent)

(define (handle-mouse lod x y mevt)
  (cond [(mouse=? mevt "button-down") (cons (make-drop x y) lod)]
        [else lod]))


(@htdf next-drops)
(@signature ListOfDrop -> ListOfDrop)
;; produce filtered and ticked list of drops
(check-expect (next-drops empty) empty)
(check-expect (next-drops (cons (make-drop 3 4)
                                (cons (make-drop 90 HEIGHT)
                                      empty)))
              (cons (make-drop 3 5)
                    empty))

(@template-origin fn-composition)

(define (next-drops lod)
  (onscreen-only (tick-drops lod)))


(@htdf tick-drops)
(@signature ListOfDrop -> ListOfDrop)
;; produce list of ticked drops
(check-expect (tick-drops empty) empty)
(check-expect (tick-drops (cons (make-drop 3 4)
                                (cons (make-drop 90 100)
                                      empty)))
              (cons (make-drop 3 (+ SPEED 4))
                    (cons (make-drop 90 (+ SPEED 100))
                          empty)))

(@template-origin ListOfDrop)

(define (tick-drops lod)
  (cond [(empty? lod) empty]
        [else 
         (cons (tick-drop (first lod))
               (tick-drops (rest lod)))]))


(@htdf tick-drop)
(@signature Drop -> Drop)
;; produce a new drop that is SPEED pixels farther down the screen
(check-expect (tick-drop (make-drop 6 9)) (make-drop 6 (+ SPEED 9)))

(@template-origin Drop)

(define (tick-drop d)
  (make-drop (drop-x d) (+ SPEED (drop-y d))))


(@htdf onscreen-only)
(@signature ListOfDrop -> ListOfDrop)
;; produce a list containing only those drops in lod that are onscreen?
(check-expect (onscreen-only empty) empty)
(check-expect (onscreen-only (cons (make-drop 3 4)
                                   (cons (make-drop 1 (+ 1 HEIGHT))
                                         empty)))
              (cons (make-drop 3 4)
                    empty))

(@template-origin ListOfDrop)

(define (onscreen-only lod)
  (cond [(empty? lod) empty]
        [else
         (if (onscreen? (first lod))
             (cons (first lod) (onscreen-only (rest lod)))
             (onscreen-only (rest lod)))]))


(@htdf onscreen?)
(@signature Drop -> Boolean)
;; produce true if d is on the screen (y within [0, HEIGHT])
(check-expect (onscreen? (make-drop 2 -1)) false)
(check-expect (onscreen? (make-drop 2  0)) true)
(check-expect (onscreen? (make-drop 2  1)) true)
(check-expect (onscreen? (make-drop 2 (- HEIGHT 1))) true)
(check-expect (onscreen? (make-drop 2    HEIGHT))    true)
(check-expect (onscreen? (make-drop 2 (+ HEIGHT 1))) false)

(@template-origin Drop)

(define (onscreen? d)  
  (<= 0 (drop-y d) HEIGHT))


(@htdf render-drops)
(@signature ListOfDrop -> Image)
;; render the drops onto MTS
(check-expect (render-drops empty) MTS)
(check-expect (render-drops (cons (make-drop 3 7) empty))
              (place-image DROP 3 7 MTS))
(check-expect (render-drops (cons (make-drop 3 7)
                                  (cons (make-drop 12 30) empty)))
              (place-image DROP 3 7 (place-image DROP 12 30 MTS)))

(@template-origin ListOfDrop)

(define (render-drops lod)
  (cond [(empty? lod) MTS]
        [else 
         (place-drop (first lod)
                     (render-drops (rest lod)))]))


(@htdf place-drop)
(@signature Drop Image -> Image)
;; place drop on img as specified by d
(check-expect (place-drop (make-drop 9 5) MTS)
              (place-image DROP 9 5 MTS))

(@template-origin Drop)

(define (place-drop d img)
  (place-image DROP (drop-x d) (drop-y d) img))
