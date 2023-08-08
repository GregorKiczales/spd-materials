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

#| Leave these templates as-is for now. |#

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



(@htdd ListOfString)

(@problem 1)
#| Refactor using local to encapsulate. |#

(@htdf all-labels)
(@signature Region -> ListOfString)
;; produce labels of all regions in region (including root)
(check-expect (all-labels S1) (list "one"))
(check-expect (all-labels G4) (list "one" "two" "three" "four" "five" "six"))

(@template-origin encapsulated Region ListOfRegion)

(define (all-labels r)
  (local [(define (all-labels--region r)
            (cond [(single? r) (list (single-label r))]
                  [else        (all-labels--lor (group-subs r))]))


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
(check-expect (all-with-color "red" S1) (list S1))
(check-expect (all-with-color "blue" S1) empty)
(check-expect (all-with-color "red"
                              (make-group "blue"
                                          (list G4
                                                (make-single "X" 90 "red"))))
              (list G1 S1 (make-single "X" 90 "red")))

(@template-origin Region ListOfRegion encapsulated)

(define (all-with-color c r)
  (local [(define (all-with-color--region c r)
            (cond [(single? r)
                   (if (string=? (single-color r) c) (list r) empty)]
                  [else
                   (if (string=? (group-color r) c)  
                       (cons r (all-with-color--lor c (group-subs r)))
                       (all-with-color--lor c (group-subs r)))]))

          (define (all-with-color--lor c lor)
            (cond [(empty? lor) empty]
                  [else               
                   (append (all-with-color--region c (first lor))
                           (all-with-color--lor c (rest lor)))]))]

    (all-with-color--region c r)))
