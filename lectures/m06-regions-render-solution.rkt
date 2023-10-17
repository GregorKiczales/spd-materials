;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-regions-render-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(require 2htdp/image)

(@assignment lectures/m06-regions-render)
;;
;; Region and ListOfRegion data definitions provided.  
;;
(@problem 1)
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


(@htdd ListOfString)


;; Design a function that renders a region and its subregions as
;; nested boxes. The rendering does not have to be pretty, but it must somehow
;; reflect the coloring, the labels and the weights.  The border function below
;; may be helpful to you.   Be sure to
;; follow the structure above, where the @htdf tag names both
;; functions, the signatures are innered, leaf purpose, tests
;; are innered, and each function has its own template tag.

(@htdf render--region render--lor)
(@signature Region -> Image)
(@signature ListOfRegion -> Image)
;; produce simple nested rendering of region
(check-expect (render--lor empty) empty-image)
(check-expect (render--region S1) (text "one" 20 "red"))
(check-expect (render--lor LOR123) (beside (render--region S1)
                                           (render--region S2)
                                           (render--region S3))) 

(check-expect (render--region G1)
              (border "red" (render--lor (inner-subs G1))))


(@template-origin Region)

(define (render--region r)
  (cond [(leaf? r)
         (text (leaf-label r)
               (leaf-weight r)
               (leaf-color r))]
        [else  
         (border (inner-color r)
                 (render--lor (inner-subs r)))])) 

(@template-origin ListOfRegion)

(define (render--lor lor)
  (cond [(empty? lor) empty-image]
        [else            
         (beside (render--region (first lor))
                 (render--lor (rest lor)))]))


(define BORDER-THICKNESS 10)

(@htdf border)
(@signature Color Image -> Image)
;; add a border of the given color around img
(check-expect (border "red" (rectangle 50 100 "solid" "blue"))
              (overlay (rectangle 50 100 "solid" "blue")
                       (rectangle 50 100 "solid" "white")
                       (rectangle (+ 50 BORDER-THICKNESS)
                                  (+ 100 BORDER-THICKNESS)
                                  "solid"
                                  "red")))   
(check-expect (border "orange" (rectangle 60 70 "solid" "blue"))
              (overlay (rectangle 60 70 "solid" "blue")
                       (rectangle 60 70 "solid" "white")
                       (rectangle (+ 60 BORDER-THICKNESS)
                                  (+ 70 BORDER-THICKNESS)
                                  "solid"
                                  "orange")))

(define (border c img)
  (overlay img
           (rectangle (image-width img)
                      (image-height img)
                      "solid"      
                      "white")
           (rectangle (+ (image-width img) BORDER-THICKNESS)
                      (+ (image-height img) BORDER-THICKNESS)
                      "solid"
                      c)))
