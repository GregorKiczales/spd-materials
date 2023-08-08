;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-regions-all-with-color-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)

(@assignment lectures/m06-regions-all-with-color)

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
;; Complete the design of a function that consumes a color and a region and
;; produces a list of all contained regions with the given color. Include the
;; root if it has that color.
;;
;; To save time, the starter has part of the solution done.  You need to
;; complete the last two check-expects, and then go on to @template-origin,
;; @template, and the final function definitions. But be sure you are able to
;; do the provided steps yourself. You will need to do them on later problems,
;; and of course problem sets, labs, and exams.
;;
;; Remember, trust the natural recursionS, and think about contributions and 
;; combinations.
;;
(@htdf all-with-color--region all-with-color--lor)
(@signature Color Region -> ListOfRegion)
(@signature Color ListOfRegion -> ListOfRegion)
;; produce all regions with given color
(check-expect (all-with-color--lor "red" empty) empty)
(check-expect (all-with-color--region "red" S1) (list S1))
(check-expect (all-with-color--region "blue" S1) empty)
(check-expect (all-with-color--lor "red" LOR123) (list S1))
(check-expect (all-with-color--region "red" G4) (list <<FILL THIS IN>>))
(check-expect (all-with-color--region "orange" G4) (list <<FILL THIS IN>>))

(define (all-with-color--region c r) empty)
(define (all-with-color--lor c r) empty)

#|
(@template-origin Region)

(define (all-with-color--region c r)
  (cond [(single? r)
         (... c
              (single-label r)
              (single-weight r)
              (single-color r))]
        [else
         (... c
              (group-color r)
              (all-with-color--lor c (group-subs r)))]))

(@template-origin ListOfRegion)

(define (all-with-color--lor c lor)
  (cond [(empty? lor) (...)]
        [else
         (... (all-with-color--region c (first lor))
              (all-with-color--lor c (rest lor)))]))
|#
