;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sum-keys-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/bsts-p2)
(@cwl ???)

(@problem 1)
;; Design a function that consumes a BST and produces the sum of all
;; the keys in the BST.
;; Here is an image of BST10 (defined below) for your reference. Use the link
;; to access the image:
;; https://cs110.students.cs.ubc.ca/bank/bst10-p2p4.png


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

(@htdf sum-keys)
(@signature BST -> Integer)
;; sum all the keys in bst
(check-expect (sum-keys false) 0)
(check-expect (sum-keys BST3) (+ 3 1 4 7))

(@template-origin BST)

(define (sum-keys bst)
  (cond [(false? bst) 0]
        [else
         (+ (node-key bst)
            (sum-keys (node-l bst))
            (sum-keys (node-r bst)))]))

