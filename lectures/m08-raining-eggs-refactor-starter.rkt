;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m08-raining-eggs-refactor-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require 2htdp/universe)
(require spd/tags)

(@assignment lectures/m08-raining-eggs-refactor)

(@cwl ???) ;replace ??? with your cwl

(@problem 1)

;;  Yoshi Eggs

;; ==========================================

;; Constants


(define WIDTH 400)
(define HEIGHT 600)

(define MARIO
  (bitmap/url "https://cs110.students.cs.ubc.ca/lectures/m04-mario.png"))


(define MTS
  (place-image MARIO
               (/ WIDTH 2)
               (- HEIGHT (/ (image-height MARIO) 2) 5)
               (empty-scene WIDTH HEIGHT)))


(define YOSHI-EGG 
  (bitmap/url "https://cs110.students.cs.ubc.ca/lectures/m04-egg.png"))


(define FALL-SPEED 5) ;pixels  per tick
(define SPIN-SPEED 5) ;degrees per tick

;; =================================================


;; Data Definitions:

(@htdd Egg)
(define-struct egg (x y r))
;; Egg is (make-egg Number Number Number)
;; interp. the x, y position of an egg in screen coordinates (pixels), and
;; rotation angle in degrees

(define E1 (make-egg 100 50 23))
(define E2 (make-egg 20 30 50))

#;
(define (fn-for-egg e)
  (... (egg-x e)    ;Number
       (egg-y e)    ;Number
       (egg-r e)))  ;Number


;; =o==================================================

;; Functions:

(@htdf main)
(@signature (listof Egg) -> (listof Egg))
;; start the world with (main empty)

(@template-origin htdw-main)

(define (main loe)
  (big-bang loe                ;(listof Egg)
    (on-tick next-eggs)        ;(listof Egg) -> (listof Egg)
    (to-draw render-eggs)      ;(listof Egg) -> Image
    (on-mouse handle-mouse)))  ;(listof Egg) Integer Integer MouseEvent -> Image



(@htdf next-eggs)
(@signature (listof Egg) -> (listof Egg))
;; produce next eggs at appropriate location and angle, drop off screen eggs
(check-expect (next-eggs empty) empty)
(check-expect (next-eggs (cons (make-egg 10 20 30) empty))
              (cons (make-egg 10 (+ 20 FALL-SPEED)(+ 30 SPIN-SPEED)) empty))

(define (next-eggs loe) loe) ;stub

















































(@htdf render-eggs)
(@signature (listof Egg) -> Image)
;; Place EGG at appropriate location and rotation on MTS for each egg in loe
(check-expect (render-eggs empty) MTS)
(check-expect (render-eggs (cons (make-egg 10 20 30)
                                 (cons (make-egg 20 30 40) empty)))
              (place-image (rotate 30 YOSHI-EGG)
                           10 20
                           (place-image (rotate 40 YOSHI-EGG)
                                        20 30
                                        MTS)))

(define (render-eggs loe) MTS) ;stub































(@htdf handle-mouse)
(@signature (listof Egg) Integer Integer MouseEvent -> (listof Egg))
;; add and egg at x, y with rotation 0 when the mouse is clicked
(check-expect (handle-mouse empty 10 40 "button-down")
              (cons (make-egg 10 40 0) empty))

(check-expect (handle-mouse empty 90 100 "drag") empty)

;(define (handle-mouse loe x y me) loe) ;stub

(@template-origin MouseEvent)

(define (handle-mouse loe x y me)
  (cond [(mouse=? me "button-down") (cons (make-egg x y 0) loe)]
        [else loe]))
