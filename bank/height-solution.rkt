;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname height-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/bsts-p3)
(@cwl ???)

(@problem 1)
;; Design the function height, that consumes a BST and produces its height.
;; Note that the height of a BST is one plus the height of its highest child.
;; You will want to use the BSL max function in your solution. The height of a
;; false tree is 0. The height of (make-node 1 "a" false false) is 1.


;; =================
;; Data definitions:

(@htdd BST)
(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
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
;;
;; Here is the BST which is used in the following examples:
;; https://cs110.students.cs.ubc.ca/bank/bsts-p1.png

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             false))
(define BST10 (make-node 10 "why" BST3 BST42))

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

(@htdf height)
(@signature BST -> Natural)
;; produce max height of BST 
(check-expect (height BST0) 0)
(check-expect (height BST1) 1)
(check-expect (height BST3) 3)
(check-expect (height BST42) 3)
(check-expect (height BST10) 4)

(@template-origin BST)

(define (height bst)
  (cond [(false? bst) 0]
        [else 
         (+ 1
            (max (height (node-l bst))
                 (height (node-r bst))))]))
