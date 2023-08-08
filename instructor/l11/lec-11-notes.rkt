;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pset-06-highlights) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


#|
TIMELINE




** Preface

Show where we are on Design Recipes page table

** Intro

Have worked hard to learn systematic approach to program design.

Grounded in theory and research.

Little look today at some of the kinds of things this enables in the future.

Just programming vs. engineering and science.


** Setup

we know that type comments like:

LOS is one of:
 - empty
 - (cons String LOS)

means that a template like:

(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

will proceed through the list to the end, and that if we fill in the base
case and combination/contribution positions correctly the result will be
correct.

It's worth taking a second to think about what we have.  We can write
the type comment, and because it is grounded in theory we AUTOMATICALLY
get the rest and we know it is correct.

This is going to let us do something pretty fantastic.  We are going to
show that by correctly simplifying type comments we can produce correct
simplified code, and that simplifying type comments is easier than
simplifying code.  This is an example of something engineers love. The
ability to simplify/optimize at a model level rather than down in the
details of the code.  Much more powerful and complex examples of this
await you in other courses, grad school, and/or industry.



|#

;; Data Definitions:

(@htdd LOS)
;; LOS is one of:
;;  - empty
;;  - (cons String LOS)
;; interp. a list of strings
(define LOS1 empty)
(define LOS2 (cons "a" (cons "b" empty)))

;; Function:

(@htdf prefix=?)
(@signature LOS LOS -> Boolean)
;; produce false if elements of lst1 do not appear at beginning of lst2 
(check-expect (prefix=? empty empty) true)
(check-expect (prefix=? empty (list "b" "c")) true)
(check-expect (prefix=? (list "b" "c") empty) false)
(check-expect (prefix=? (list "a" "b") (list "a" "b" "c")) true)
(check-expect (prefix=? (list "a" "b") (list "b" "c")) false)
(check-expect (prefix=? (list "a" "b") (list "a" "b")) true)
(check-expect (prefix=? (list "a" "b") (list "a")) false)

#|
CROSS PRODUCT OF TYPE COMMENTS TABLE                          

                                     
   lst1          lst2     empty          (cons String LOS)          
          
   empty                  true  [1]         true  [1]

   (cons String LOS)      false [2]        (and (string=? <firsts>)  [3] 
                                                (prefix=? <rests>))
|#

(@template 2-one-of)

(define (prefix=? lst1 lst2)
  (cond [(empty? lst1) true]   ;[1]
        [(empty? lst2) false]  ;[2]
        [else                  ;[3]
         (and (string=? (first lst1) (first lst2))
              (prefix=? (rest lst1) (rest lst2)))]))


(@htdf merge)
(@signature LON LON -> LON)
;; merge two lists of sorted numbers into ascending order; preserves duplicates
;; CONSTRAINT: both lists must be already sorted in ascending order
(check-expect (merge empty empty) empty)
(check-expect (merge empty (list 2 3 5)) (list 2 3 5))
(check-expect (merge (list 1 4 6) empty) (list 1 4 6))
(check-expect (merge (list 1 4 6) (list 2 3 5)) (list 1 2 3 4 5 6))
(check-expect (merge (list 2 3 5) (list 1 4 6)) (list 1 2 3 4 5 6))
(check-expect (merge (list 1 2 3) (list 4 5 6)) (list 1 2 3 4 5 6))
(check-expect (merge (list 1 2 3) (list 1 2 3)) (list 1 1 2 2 3 3))

#|
l2                empty                   (cons N LON)  
l1

empty             l2 (was empty) [1]      l2                               [1]

(cons N LON)      l1             [2]      (if (< (first l1) (first l2))    [3]
                                              (cons (first l1)
                                                    (merge (rest l1) l2))
                                              (cons (first l2)
                                                    (merge l1 (rest l2))))
|#

(@template-origin 2-one-of)

(define (merge l1 l2)  
  (cond [(empty? l1) l2]               ;[1]
        [(empty? l2) l1]               ;[2]
        [else                          ;[3]
         (if (< (first l1) (first l2))
             (cons (first l1)
                   (merge (rest l1) l2))
             (cons (first l2)        
                   (merge l1 (rest l2))))]))


