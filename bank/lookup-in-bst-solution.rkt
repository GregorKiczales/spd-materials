;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname lookup-in-bst-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/bsts-l3)
(@cwl ???)

;; Consider the following data definition for a binary search tree: 


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
;; Here is an example of a BST:
;; https://cs110.students.cs.ubc.ca/bank/bsts-l3.png

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))

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

(@problem 1)
;; Complete the design of the lookup-key function below. Note that because this
;; is a search function it will sometimes 'fail'. This happens if it is called
;; with an key that does not exist in the BST it is provided. If this happens
;; the function should produce false. The signature for such a function is
;; written in a special way as shown below.
;; 
;; You may refer to the image as you create your examples:
;; https://cs110.students.cs.ubc.ca/bank/bsts-l3.png


(@htdf lookup-key)
(@signature BST Natural -> String or false)
;; Try to find node with given key, if found produce value; if not produce false

(check-expect (lookup-key BST0  99) false)
(check-expect (lookup-key BST1   1) "abc")
(check-expect (lookup-key BST1   0) false) ;L fail
(check-expect (lookup-key BST1  99) false) ;R fail
(check-expect (lookup-key BST10  1) "abc") ;L L succeed
(check-expect (lookup-key BST10  4) "dcj") ;L R succeed
(check-expect (lookup-key BST10 27) "wit") ;R L succeed
(check-expect (lookup-key BST10 50) "dug") ;R R succeed

;(define (lookup-key t k) "") ;stub

(@template-origin BST)

(define (lookup-key t k)
  (cond [(false? t) false]
        [else
         (cond [(= k (node-key t)) (node-val t)]
               [(< k (node-key t)) ;should we go left?
                (lookup-key (node-l t) k)]
               [(> k (node-key t)) ;should we go right?
                (lookup-key (node-r t) k)])]))
