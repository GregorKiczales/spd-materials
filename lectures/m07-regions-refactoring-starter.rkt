;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-regions-all-with-color-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)
(@assignment lectures/m07-regions-refactoring)

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

#| Leave these templates as-is for now. |#


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

(@problem 1)
#| Refactor using local to encapsulate. |#

(@htdf all-labels--region all-labels--lor)
(@signature Region -> ListOfString)
(@signature ListOfRegion -> ListOfString)
;; produce labels of all regions in region (including root)
(check-expect (all-labels--lor empty) empty)
(check-expect (all-labels--region S1) (list "one"))
(check-expect (all-labels--lor LOR123) (list "one" "two" "three"))
(check-expect (all-labels--region G4)
              (list "one" "two" "three"
                    "four" "five" "six"))

(@template-origin Region)

(define (all-labels--region r)
  (cond [(leaf? r) (list (single-label r))]
        [else
         (all-labels--lor (inner-subs r))]))

(@template-origin ListOfRegion)

(define (all-labels--lor lor)
  (cond [(empty? lor) empty]
        [else
         (append (all-labels--region (first lor))
                 (all-labels--lor (rest lor)))]))


(@problem 2)
#| Refactor using local to encapsulate. |#

(@htdf all-with-color--region all-with-color--lor)
(@signature Color Region -> ListOfRegion)
(@signature Color ListOfRegion -> ListOfRegion)
;; produce all regions with given color
(check-expect (all-with-color--lor "red" empty) empty)
(check-expect (all-with-color--region "red" S1) (list S1))
(check-expect (all-with-color--region "blue" S1) empty)
(check-expect (all-with-color--lor "red" LOR123) (list S1))
(check-expect
 (all-with-color--region "red"
                         (make-inner "blue"
                                     (list G4
                                           (make-leaf "X" 90 "red"))))
 (list G1 S1 (make-leaf "X" 90 "red")))

(@template-origin Region)

(define (all-with-color--region c r)
  (cond [(leaf? r) (if (string=? (single-color r) c) (list r) empty)]
        [else
         (if (string=? (inner-color r) c)
             (cons r (all-with-color--lor c (inner-subs r)))
             (all-with-color--lor c (inner-subs r)))]))

(@template-origin ListOfRegion)

(define (all-with-color--lor c lor)
  (cond [(empty? lor) empty]
        [else
         (append (all-with-color--region c (first lor))
                 (all-with-color--lor c (rest lor)))]))
