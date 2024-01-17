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
(check-expect (all-with-color--region "red" L1) (list L1))
(check-expect (all-with-color--region "blue" L1) empty)
(check-expect (all-with-color--lor "red" LOR123) (list L1))
(check-expect (all-with-color--region "red" I4) (list "<<FILL-THIS-IN>>"))
(check-expect (all-with-color--region "orange" I4) (list "<<FILL-THIS-IN>>"))

(define (all-with-color--region c r) empty)
(define (all-with-color--lor c r) empty)

#|
(@template-origin Region)

(define (all-with-color--region c r)
  (cond [(leaf? r)
         (... c
              (leaf-label r)
              (leaf-weight r)
              (leaf-color r))]
        [else
         (... c
              (inner-color r)
              (all-with-color--lor c (inner-subs r)))]))

(@template-origin ListOfRegion)

(define (all-with-color--lor c lor)
  (cond [(empty? lor) (...)]
        [else
         (... (all-with-color--region c (first lor))
              (all-with-color--lor c (rest lor)))]))
|#
