;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname balance-factor-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@assignment bank/bsts-p5)
(@cwl ???)

(@problem 1)
;; As discussed in lecture, for optimal lookup time we want a BST to be
;; balanced. 
;; The oldest approach to this is called AVL self-balancing trees and was
;; invented in 1962. 
;; The remainder of this problem set is based on AVL trees.
;;
;; An individual node is balanced when the height of its left and right branches
;; differ by no more than 1. A tree is balanced when all its nodes are balanced.
;;
;; a) Design the function balance-factor that consumes a node and produces its
;; balance factor, which is defined as the height of its left child minus the
;; height of its right child.
;;
;; b) Use your function in part a) to design the function balanced?, which
;; consumes a BST and produces true if the tree is balanced.
;;
;; Once you have the function, use it to compare what happens with the following
;; two sequences of insertions:
;;
;;
;; (insert 4 "a" 
;;         (insert 5 "a"
;;                 (insert 6 "a" 
;;                         (insert 7 "a" 
;;                                 (insert 8 "a" false)))))
;;        
;;        
;; (insert 4 "a" 
;;         (insert 5 "a"
;;                 (insert 8 "a" 
;;                         (insert 7 "a" 
;;                                 (insert 6 "a" false))))) 
;;
;; (The function insert is defined in a previous problem, bsts-p4. It
;;  will produce a new BST with a node with the given key and value inserted
;;  into the given BST at the appropriate place)
;; 
;; The examples in the data definition are based on this BST:
;; https://cs110.students.cs.ubc.ca/bank/bsts-p1.png


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

(@htdf balance-factor)
(@signature BST -> Natural)
;; consumes a BST and produces its balance factor
(check-expect (balance-factor BST1) 0)
(check-expect (balance-factor BST3) -1)
(check-expect (balance-factor BST42) 2)
(check-expect (balance-factor BST10) 0)
(check-expect (balance-factor
               (make-node 42 "ily"
                          false
                          (make-node 27 "wit" 
                                     (make-node 14 "olp" false false) 
                                     false))) -2)

(@template-origin Number) ;It feels like a fn-composition, but it isn't
;;                        ;really a composition of two calls to height.
;;                        ;So this template origin says we are treating
;;                        ;the BST as atomic data.

(define (balance-factor bst) 
  (- (height (node-l bst))
     (height (node-r bst))))


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


(@htdf balanced?)
(@signature BST -> Boolean)
;; produce true if a BST is balanced
(check-expect (balanced? BST0) true)
(check-expect (balanced? BST1) true)
(check-expect (balanced? BST3) true)
(check-expect (balanced? BST42) false)
(check-expect (balanced? (make-node 27 "wit" 
                                    (make-node 14 "olp" false false) 
                                    false)) true)
(check-expect (balanced? (make-node 42 "ily"
                                    false
                                    (make-node 27 "wit" 
                                               (make-node 14 "olp" false false) 
                                               false))) false)

(check-expect (balanced? BST10) false)

(@template-origin BST)

(define (balanced? bst) 
  (cond [(false? bst) true]
        [else 
         (and  (<= -1 (balance-factor bst) 1)
               (balanced? (node-l bst))
               (balanced? (node-r bst)))]))
