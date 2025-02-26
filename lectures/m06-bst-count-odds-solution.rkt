;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname m06-bst-count-odds-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require spd/tags)
(@assignment lectures/m06-bst-count-odds)



(@problem 1)
(define TEXT-SIZE 60)
(define TEXT-COLOR "black")

;; Data definitions:

(@htdd BST)
(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; CONSTRAINT: (INVARIANT) for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree

;; An example tree is at
;; https://cs110.students.cs.ubc.ca/lectures/m06-bst.png

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))


#|
PROBLEM: Complete the data definition.  Include example constants for nodes 27,
42, and 10. Also write a template. As of module 6A you are no longer required
to have a @dd-template-rules tag.  But you must still follow the rules!
|#

(define BST27 (make-node 27 "wit"
                         (make-node 14 "olp" false false)
                         false))
(define BST42 (make-node 42 "ily"
                         BST27
                         (make-node 50 "dug" false false)))
(define BST10 (make-node 10 "why" BST3 BST42))

(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t) 
              (node-val t)    
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))



;; Function:



#|
PROBLEM: Design a function that consumes a bst and counts the number of
nodes in the tree that have an odd key.(Hint - odd? predicate exists in BSL)
|#
(@htdf count-odds)
(@signature BST -> Natural)
;; count the number of nodes with odd valued keys in the bst
(check-expect (count-odds BST0) 0)
(check-expect (count-odds BST1) 1)
(check-expect (count-odds BST42) 1)
(check-expect (count-odds BST10) 4)

(@template-origin BST)

(define (count-odds t)
  (cond [(false? t) 0]      
        [else
         (+ (if (odd? (node-key t)) 1 0)
            (count-odds (node-l t))
            (count-odds (node-r t)))]))
