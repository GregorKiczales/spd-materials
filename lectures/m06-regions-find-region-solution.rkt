;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-regions-find-region-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(@assignment lectures/m06-regions-find-region)
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


(@htdf find-region--region find-region--lor)
(@signature String Region -> Region or false)
(@signature String ListOfRegion  -> Region or false)
;; find region w/ given label
(check-expect (find-region--lor "one" empty) false)
(check-expect (find-region--region "one" S1) S1)
(check-expect (find-region--region "one" S2) false)
(check-expect (find-region--lor "two" LOR123) S2)
(check-expect (find-region--region "three" G4) S3)

(@template-origin Region)

(@template
 (define (find-region--region l r)
   (cond [(leaf? r)
          (... l
               (leaf-label r)
               (leaf-weight r)
               (leaf-color r))]
         [else
          (... l
               (inner-color r)
               (find-region--lor l (inner-subs r)))])))

(define (find-region--region l r)   
  (cond [(leaf? r) (if (string=? (leaf-label r) l) r false)]
        [else        (find-region--lor l (inner-subs r))]))

(@template-origin ListOfRegion try-catch)

(@template
 (define (find-region--lor l lor)
   (cond [(empty? lor) (... l)]
         [else
          (if (not (false? (find-region--region l (first lor))))
              (find-region--region l (first lor))      
              (find-region--lor l (rest lor)))])))

(define (find-region--lor l lor)
  (cond [(empty? lor) false]  
        [else                         
         (if (not (false? (find-region--region l (first lor))))
             (find-region--region l (first lor))
             (find-region--lor l (rest lor)))]))
