;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lec07-arrows) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(@htdd Egg)
(define-struct egg (x y r))
;; Egg is (make-egg Number Number Number)
;; interp. the x, y position of an egg in screen coordinates (pixels),
;;         and rotation angle in degrees




(define (fn-for-egg e)
  (... (egg-x e)    ;Number
       (egg-y e)    ;Number
       (egg-r e)))  ;Number



(@htdd ListOfEgg)
;; ListOfEgg is one of:
;; - empty
;; - (cons Egg ListOfEgg)
;; interp. a list of eggs



(define (fn-for-loe loe)
  (cond [(empty? loe) (...)]
        [else
         (... (fn-for-egg (first loe))
              (fn-for-loe (rest loe)))]))

