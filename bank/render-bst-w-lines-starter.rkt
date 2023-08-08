;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname render-bst-w-lines-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require spd/tags)

(@assignment bank/bsts-p6)
(@cwl ???)

(@problem 1)
;; Given the following data definition for a binary search tree,
;; design a function that consumes a bst and produces a SIMPLE 
;; rendering of that bst including lines between nodes and their 
;; subnodes.


;; =================
;; Constants

(define TEXT-SIZE  14)
(define TEXT-COLOR "BLACK")

(define KEY-VAL-SEPARATOR ":")

(define MTTREE (rectangle 20 1 "solid" "white"))



;; =================
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

#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))



;; =================
;; Functions:

;; Below is a link that leads to a sketch of one way the lines could work. 
;; What this sketch does is allows us to see the structure of
;; the functions pretty clearly. We'll have one helper for
;; the key value image, and one helper to draw the lines.
;; Each of those produces a rectangular image of course.
;;
;; https://cs110.students.cs.ubc.ca/bank/bst-fn.png
;;
;; Here is a link to a sketch of the helper that draws the lines:
;;
;; https://cs110.students.cs.ubc.ca/bank/bst-helper.png
;;
;; where lw means width of left subtree image and
;;       rw means width of right subtree image
;;
;; And here is a link to an image of BST10 for reference:
;; 
;; https://cs110.students.cs.ubc.ca/bank/bst10.png


