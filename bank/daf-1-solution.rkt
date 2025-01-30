;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname f-p5-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)
(require 2htdp/image)

(@assignment bank/daf-1)

(@cwl ???)   ;fill in your CWL here (same as for problem sets)


(@problem 1) ;do not edit or delete this line
(@problem 2) ;do not edit or delete this line


#|

Consider the following data definitions.

|#
(@htdd Tree Branch)
(define-struct tree   (name branches))
(define-struct branch (num tree))
;;
;; Tree is (make-tree String (listof Branch))
;;
;; Branch is (make-branch Natural Tree)
;;
;; interp. an arb-arity tree in which each subtree has a name, and 
;;         each branch has a number. So unlike simpler arb-arity
;;         trees, in these trees there is an explicit Branch between
;;         a tree and each of its subtrees.

(define TA (make-tree "A" empty))
(define TB (make-tree "B" empty))
(define TC (make-tree "C" empty))
(define TD (make-tree "D" empty))

(define B1 (make-branch 1 TA))
(define B2 (make-branch 2 TB))
(define B3 (make-branch 3 TC))
(define B4 (make-branch 4 TD))

(define TFOO (make-tree "FOO" (list B1 B2)))
(define TBAR (make-tree "BAR" (list B3)))

(define B11 (make-branch 11 TFOO))
(define B12 (make-branch 12 TBAR))

(define TTOP (make-tree "TOP" (list B11 B12 B4)))


(@htdf fold-tree)
(@signature (String Y -> X)
            (Z Y -> Y)
            (Natural X -> Z)
            Y
            Tree
            -> X)
;; abstract fold for Tree
;
(check-expect (fold-tree make-tree cons make-branch empty TTOP) TTOP)
(check-expect (fold-tree (lambda (n rmr) rmr) + + 0 TTOP) (+ 1 2 3 4 11 12))


(@template-origin encapsulated Tree (listof Branch) Branch)

(define (fold-tree c1 c2 c3 b1 t)
  (local [(define (fn-for-t t)
            (c1 (tree-name t)
                (fn-for-lob (tree-branches t))))

          (define (fn-for-lob lob)
            (cond [(empty? lob) b1]
                  [else
                   (c2 (fn-for-b (first lob))
                       (fn-for-lob (rest lob)))]))

          (define (fn-for-b b)
            (c3 (branch-num b)
                (fn-for-t (branch-tree b))))]

    (fn-for-t t)))
