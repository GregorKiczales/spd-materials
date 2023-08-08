;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname m07-avoid-recomputation-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)
(@assignment lectures/m07-avoid-recomputation)

(@cwl ???) ;replace ??? with your cwl

(@problem 1)
;; render-bst-w-lines-faster-starter.rkt



;; Constants

(define TEXT-SIZE  14)
(define TEXT-COLOR "BLACK")

(define KEY-VAL-SEPARATOR ":")

(define MTTREE (rectangle 20 1 "solid" "white"))



;; Data definitions:

(@htdd BST)

(define-struct node (key val l r))
;; BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means no BST, or empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST7 (make-node 7 "ruf" false false)) 
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))
(define BST100 
  (make-node 100 "large" BST10 false))

(@dd-template-rules one-of atomic-distinct compound self-ref self-ref)

(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))

;; Functions:


#|
PROBLEM:

Design a function that consumes a bst and produces a SIMPLE 
rendering of that bst including lines between nodes and their 
subnodes.
|#

(@htdf render-bst)
(@signature BST -> Image)
;; produce SIMPLE rendering of bst
;; CONSTRAINT: bst is relatively well balanced

(check-expect (render-bst false) MTTREE)
(check-expect (render-bst BST1)
              (above (render-key-val 1 "abc") 
                     (lines (image-width (render-bst false))
                            (image-width (render-bst false)))
                     (beside (render-bst false)
                             (render-bst false))))

(@template-origin BST)

(define (render-bst t)
  (cond [(false? t) MTTREE]
        [else
         (above (render-key-val (node-key t) (node-val t))
                (lines (image-width (render-bst (node-l t)))
                       (image-width (render-bst (node-r t))))
                (beside (render-bst (node-l t))
                        (render-bst (node-r t))))]))


(@htdf render-key-val)
(@signature Integer String -> Image)
;; render key and value to form the body of a node
(check-expect (render-key-val 99 "foo") 
              (text (string-append "99" KEY-VAL-SEPARATOR "foo")
                    TEXT-SIZE
                    TEXT-COLOR))

(@template-origin Integer)

(define (render-key-val k v)
  (text (string-append (number->string k)
                       KEY-VAL-SEPARATOR
                       v)
        TEXT-SIZE
        TEXT-COLOR))

(@htdf lines)
(@signature Natural Natural -> Image)
;; produce lines to l/r subtrees based on width of those subtrees
(check-expect (lines 60 130)
              (add-line (add-line (rectangle (+ 60 130) (/ 190 4)
                                             "solid"
                                             "white")
                                  (/ (+ 60 130) 2) 0
                                  (/ 60 2)         (/ 190 4)
                                  "black")
                        (/ (+ 60 130) 2) 0
                        (+ 60 (/ 130 2)) (/ 190 4)
                        "black"))

(@template-origin Natural)

(define (lines lw rw)
  (add-line (add-line (rectangle (+ lw rw) (/ (+ lw rw) 4) "solid" "white")  
                      (/ (+ lw rw) 2)  0
                      (/ lw 2)         (/ (+ lw rw) 4)
                      "black")
            (/ (+ lw rw) 2)  0
            (+ lw (/ rw 2))  (/ (+ lw rw) 4)
            "black"))

#|

PROBLEM

Consider the render-bst function above as it operates on a simple binary tree.

When render-bst is called on the root, how many times does render-bst end up
being called on the direct sub-nodes of the root?

How many times is it called on their sub-nodes?

And their subnodes?

At depth n, how many times is render-bst called on each node?

|#
