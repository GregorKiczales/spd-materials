;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-regions-find-region-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)
(@assignment lectures/m07-regions-search)

(@cwl ???) ;replace ??? with your cwl
;;
;; Region and ListOfRegion data definitions provided.  
;;

(@htdd Region ListOfRegion)
(define-struct leaf (label weight color))
(define-struct inner (color subs))
;; Region is one of:
;;  - (make-leaf String Natural Color)
;;  - (make-inner Color ListOfRegion)
;; interp.
;;  an arbitrary-arity tree of regions
;;  leaf regions have label, weight and color
;;  inners have a color and a list of sub-regions
;;
;;  weight is a unitless number indicating how much weight
;;  the given leaf region contributes to whole tree

;; ListOfRegion is one of:
;;  - empty
;;  - (cons Region ListOfRegion)
;; interp. a list of regions

;; All the Ss and Gs are Regions
(define S1 (make-leaf "one" 20 "red"))
(define S2 (make-leaf "two" 40 "blue"))
(define S3 (make-leaf "three" 60 "orange"))
(define S4 (make-leaf "four" 30 "black"))
(define S5 (make-leaf "five" 50 "purple"))
(define S6 (make-leaf "six" 80 "yellow"))

(define G1 (make-inner "red"  (list S1 S2 S3)))
(define G2 (make-inner "blue" (list G1 S4)))
(define G3 (make-inner "orange" (list S5 S6)))
(define G4 (make-inner "black" (list G2 G3)))

(define LORE empty)
(define LOR123 (list S1 S2 S3))

(@problem 1)
#| Use local to encapsulate these templates. |#

(@template-origin Region)

(define (fn-for-region r)
  (cond [(leaf? r)
         (... (leaf-label r)
              (leaf-weight r)
              (leaf-color r))]
        [else
         (... (inner-color r)
              (fn-for-lor (inner-subs r)))]))

(@template-origin ListOfRegion)

(define (fn-for-lor lor)
  (cond [(empty? lor) (...)]
        [else
         (... (fn-for-region (first lor))
              (fn-for-lor (rest lor)))]))



(@problem 2)
#|
Design a function that consumes a string and a region
and looks for a region with the given label.  If there is one
the function should produce the first one it finds.  If there is
not one it should signal failure by producing false.

Use the encapsulated templates from Problem 1 above.
|#

