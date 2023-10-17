;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-regions-total-weight-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m06-regions-total-weight)
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



;; Design a function that produces the total weight of a region

(@htdf total-weight--region total-weight--lor)
(@signature Region -> Natural)
(@signature ListOfRegion -> Natural)
;; produce total weight of region / list of region
(check-expect (total-weight--region S1) 20)
(check-expect (total-weight--region S2) 40)
(check-expect (total-weight--lor empty) 0)
(check-expect (total-weight--lor (list S1 S2 S3)) (+ 20 40 60))             
(check-expect (total-weight--region (make-inner "red" empty)) 0)
(check-expect (total-weight--region G1) (+ 20 40 60))
(check-expect (total-weight--region G4) (+ 20 40 60 30 50 80))

(@template-origin Region)

(@template
 (define (total-weight--region r)
   (cond [(leaf? r)
          (... (leaf-label r)
               (leaf-weight r)
               (leaf-color r))]
         [else
          (... (inner-color r)
               (total-weight--lor (inner-subs r)))])))

(define (total-weight--region r)
  (cond [(leaf? r) (leaf-weight r)]    
        [else (total-weight--lor (inner-subs r))]))

(@template-origin ListOfRegion)

(@template
 (define (total-weight--lor lor)
   (cond [(empty? lor) (...)]
         [else
          (... (total-weight--region (first lor))
               (total-weight--lor (rest lor)))])))

(define (total-weight--lor lor)
  (cond [(empty? lor) 0]       
        [else
         (+ (total-weight--region (first lor))
            (total-weight--lor (rest lor)))]))
