;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m07-regions-refactoring-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;; All the Ls and Is are Regions
(define L1 (make-leaf "one" 20 "red"))
(define L2 (make-leaf "two" 40 "blue"))
(define L3 (make-leaf "three" 60 "orange"))
(define L4 (make-leaf "four" 30 "black"))
(define L5 (make-leaf "five" 50 "purple"))
(define L6 (make-leaf "six" 80 "yellow"))

(define I1 (make-inner "red"  (list L1 L2 L3)))
(define I2 (make-inner "blue" (list I1 L4)))
(define I3 (make-inner "orange" (list L5 L6)))
(define I4 (make-inner "black" (list I2 I3)))

(define LORE empty)
(define LOR123 (list L1 L2 L3))

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

(@htdf all-labels)
(@signature Region -> ListOfString)
;; produce labels of all regions in region (including root)
(check-expect (all-labels L1) (list "one"))
(check-expect (all-labels I4) (list "one" "two" "three" "four" "five" "six"))

(@template-origin encapsulated Region ListOfRegion)

(define (all-labels r)
  (local [(define (all-labels--region r)
            (cond [(leaf? r) (list (leaf-label r))]
                  [else      (all-labels--lor (inner-subs r))]))


          (define (all-labels--lor lor)
            (cond [(empty? lor) empty]
                  [else
                   (append (all-labels--region (first lor))
                           (all-labels--lor (rest lor)))]))]

    (all-labels--region r)))



(@problem 2)
#| Refactor using local to encapsulate. |#

(@htdf all-with-color)
(@signature Color Region -> ListOfRegion)
;; produce all regions with given color
(check-expect (all-with-color "red" L1) (list L1))
(check-expect (all-with-color "blue" L1) empty)
(check-expect (all-with-color "red"
                              (make-inner "blue"
                                          (list I4
                                                (make-leaf "X" 90 "red"))))
              (list I1 L1 (make-leaf "X" 90 "red")))

(@template-origin Region ListOfRegion encapsulated)

(define (all-with-color c r)
  (local [(define (all-with-color--region c r)
            (cond [(leaf? r)
                   (if (string=? (leaf-color r) c) (list r) empty)]
                  [else
                   (if (string=? (inner-color r) c)  
                       (cons r (all-with-color--lor c (inner-subs r)))
                       (all-with-color--lor c (inner-subs r)))]))

          (define (all-with-color--lor c lor)
            (cond [(empty? lor) empty]
                  [else               
                   (append (all-with-color--region c (first lor))
                           (all-with-color--lor c (rest lor)))]))]

    (all-with-color--region c r)))
