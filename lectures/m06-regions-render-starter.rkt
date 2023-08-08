;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-regions-render-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(require 2htdp/image)

(@assignment lectures/m06-regions-render)

(@cwl ???) ;replace ??? with your cwl

;;
;; Region and ListOfRegion data definitions provided. 
;;
(@problem 1)
(@htdd Region ListOfRegion)
(define-struct single (label weight color))
(define-struct group (color subs))
;; Region is one of:
;;  - (make-single String Natural Color)
;;  - (make-group Color ListOfRegion)
;; interp.
;;  an arbitrary-arity tree of regions
;;  single regions have label, weight and color
;;  groups have a color and a list of sub-regions
;;
;;  weight is a unitless number indicating how much weight
;;  the given single region contributes to whole tree

;; ListOfRegion is one of:
;;  - empty
;;  - (cons Region ListOfRegion)
;; interp. a list of regions

;; All the Ss and Gs are Regions
(define S1 (make-single "one" 20 "red"))
(define S2 (make-single "two" 40 "blue"))
(define S3 (make-single "three" 60 "orange"))
(define S4 (make-single "four" 30 "black"))
(define S5 (make-single "five" 50 "purple"))
(define S6 (make-single "six" 80 "yellow"))

(define G1 (make-group "red"  (list S1 S2 S3)))
(define G2 (make-group "blue" (list G1 S4)))
(define G3 (make-group "orange" (list S5 S6)))
(define G4 (make-group "black" (list G2 G3)))

(define LORE empty)
(define LOR123 (list S1 S2 S3))

(@template-origin Region)

(define (fn-for-region r)
  (cond [(single? r)
         (... (single-label r)
              (single-weight r)
              (single-color r))]
        [else
         (... (group-color r)
              (fn-for-lor (group-subs r)))]))

(@template-origin ListOfRegion)

(define (fn-for-lor lor)
  (cond [(empty? lor) (...)]
        [else
         (... (fn-for-region (first lor))
              (fn-for-lor (rest lor)))]))





;;
;; Design a function that renders a region and its subregions as
;; nested boxes. The rendering does not have to be pretty, but it must somehow
;; reflect the coloring, the labels and the weights.  The border function below
;; will be helpful to you.
;;
;; To save time, the starter has part of the solution done.  You need to
;; fully understand all the check-expects, and then go on to @template-origin,
;; @template, and the final function definitions. But be sure you are able to
;; do the provided steps yourself. You will need to do them on later problems,
;; and of course problem sets, labs, and exams.  
;; 
;; Remember, trust the natural recursionS, and think about contributions and 
;; combinations.
;;
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
              (border "red" (render--lor (group-subs G1))))















(define BORDER-THICKNESS 5)

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
