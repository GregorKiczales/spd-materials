;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname snow) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))

;; Snow!

(require 2htdp/image)
(require 2htdp/universe)


;; Constants:

(define SIZE 400)

(define MTS (rectangle SIZE SIZE "solid" "lightsteelblue"))

(define FLAKE-RADIUS       20) 
(define FLAKE-INNER-RADIUS  4)

(define FR/2 (/ FLAKE-RADIUS  2))

(define FLAKE (radial-star 8 (/ FLAKE-RADIUS 10) FLAKE-RADIUS "solid" "white"))


;; Data definitions:

(define-struct flake (x y dx dy))
;; Flake is 
;;  (make-flake Number Number Number Number)
;; interp. A flake at x, y moving by dx, dy.

(define B1 (make-flake 1 2 3 5))


;; Functions:

;; -> Number
;; run the flake program
(define (main lof)
  (big-bang lof
    (on-mouse click-handler)
    (to-draw  render)
    (on-tick  tock)))



;; (listof Flake) Nat Nat MouseEvent -> Number
;; produces n
;; Effect: on button-down add new flake at x, y to all-flakes
(check-random (click-handler '() 3 5 "button-down")
              (list (new-flake-at 3 5)))
(check-random (click-handler (list (make-flake 2 3 1 1)) 3 5 "button-down")
              (list (new-flake-at 3 5)
                    (make-flake 2 3 1 1)))

(define (click-handler lof x y me)
  (cond [(mouse=? me "button-down") (cons (new-flake-at x y) lof)]
        [else lof]))



;; Number Number -> Flake
;; produce a new flake at x, y, motionles, random colour
(check-random (new-flake-at 1 2) (make-flake 1 2 0 (add1 (random 7))))

(define (new-flake-at x y)
  (make-flake x y 0 (add1 (random 7))))



;; (listof Flake) -> Image
;; produces image of all flakes in flakes on MTS
(check-expect (render (list (make-flake 1 2 1 1)
                            (make-flake 4 5 -1 -1)))
              (place-flake (make-flake 1 2 1 1)
                           (place-flake (make-flake 4 5 -1 -1)
                                        MTS)))

(define (render lof)
  (foldr place-flake MTS lof))



;; Flake -> Image
;; Render b onto img
(check-expect (place-flake (make-flake 1 2 3 5) MTS)
              (place-image FLAKE 1 2 MTS))

(define (place-flake b img)
  (local [(define x (flake-x b))
          (define y (flake-y b))]
    (place-image FLAKE x y img)))



;; (listof Flake) -> (listof Flake)
;; tock each flake in all-flakes
(check-random
 (tock (list (make-flake 1 2 3 4) (make-flake 4 5 6 7)))
 (map tock-flake  (list (make-flake 1 2 3 4) (make-flake 4 5 6 7))))

(define (tock lof)
  (map tock-flake lof))



;; Flake -> Flake
;; bounce off edges; or move according to dx, dy and a puff of air

(check-expect (tock-flake (make-flake 0 100 -1  1))
              (make-flake 2   100  1 1))
(check-expect (tock-flake (make-flake SIZE 100 1  1))
              (make-flake (- SIZE 2)   100  -1 1))
(check-expect (tock-flake (make-flake 100 SIZE  1 1))
              (make-flake 100 SIZE  1 1))
              

(define (tock-flake b)
  (local [(define  x (flake-x  b))
          (define  y (flake-y  b))
          (define dx (flake-dx b))
          (define dy (flake-dy b))]
    
    (cond [(touch-lef? x) (make-flake (+ x 2) y  1 dy)]
          [(touch-rig? x) (make-flake (- x 2) y -1 dy)]
          [(touch-bot? y) b]
          [else
           (make-flake (+ x (* .06 dx)) 
                       (+ y (* .1 dy)) 
                       (puff dx) 
                       dy)])))



;; Number -> Number
;; given an x/y velocity of a flake, change it by +/- 1 for a puff of air
;; <not tested because of use of random>
(define (puff dxy)
  (+ dxy (- (random 2) .5)))




;; touch-lef/bot/rig?: Number -> Boolean
;; produce true if edge of flake touches edge of box
(check-expect (touch-bot? (- SIZE FR/2))   true)
(check-expect (touch-bot? (- SIZE FR/2 1)) false)

(check-expect (touch-lef?         FR/2)    true)
(check-expect (touch-lef? (add1   FR/2))   false)
(check-expect (touch-rig? (- SIZE FR/2))   true)
(check-expect (touch-rig? (- SIZE FR/2 1)) false)

(define (touch-lef? x) (<= x         FR/2))
(define (touch-bot? y) (>= y (- SIZE FR/2)))
(define (touch-rig? x) (>= x (- SIZE FR/2)))


