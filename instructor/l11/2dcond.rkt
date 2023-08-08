#lang unstable/2d racket

(require unstable/2d/cond)
(require test-engine/racket-tests)

;; =================================================================
;; =================================================================
;; Data definitions:


(define-struct node (k v l r))
;; BinaryTree is one of:
;;  - false
;;  - (make-node Natural String BinaryTree BinaryTree)
;; interp. 
;;  a binary tree, each node has a key, value and left/right children
(define BT1 false)
(define BT2 (make-node 1 "a" false false))
(define BT3 (make-node 4 "d"
                       (make-node 2 "b"
                                  (make-node 1 "a" false false)
                                  (make-node 3 "c" false false))
                       (make-node 7 "g" false false)))

#;
(define (fn-for-bt bt)
  (cond [(false? bt) (...)]
        [else
         (... (node-k bt)
              (node-v bt)
              (fn-for-bt (node-l bt))
              (fn-for-bt (node-r bt)))]))


;; Path is one of:
;; - empty
;; - (cons "L" Path)
;; - (cons "R" Path)
;; interp. 
;;  A sequence of left and right 'turns' down through a BinaryTree
;;  (list "L" "R" "R") means take the left child of the root, then
;;  the right child of that node, and the right child again.
;;  empty means you have arrived at the destination.
(define P1 empty)
(define P2 (list "L" "R"))

#;
(define (fn-for-path p)
  (cond [(empty? p) (...)]
        [(string=? (first p) "L") (... (fn-for-path (rest p)))]
        [(string=? (first p) "R") (... (fn-for-path (rest p)))]))



;; BinaryTree Path -> Boolean
;; determine whether bt has the path p.
 
(define (has-path? bt p)
 #2dcond
 ╔════════════════════╦════════════════════╦══════════════════════════════════╗
 ║                    ║                    ║                                  ║
 ║                    ║     (false? bt)    ║        (node? bt)                ║
 ║                    ║                    ║                                  ║
 ║                    ║                    ║                                  ║
 ╠════════════════════╬════════════════════╬══════════════════════════════════╣
 ║                    ║                    ║                                  ║
 ║                    ║                    ║                                  ║
 ║  (empty? p)        ║                    ║         true                     ║
 ║                    ║                    ║                                  ║
 ╠════════════════════╣                    ╠══════════════════════════════════╣
 ║                    ║                    ║                                  ║
 ║(string=? (first p) ║                    ║  (has-path? (node-l bt) (rest p))║
 ║          "L")      ║     false          ║                                  ║
 ║                    ║                    ║                                  ║
 ╠════════════════════╣                    ╠══════════════════════════════════╣
 ║                    ║                    ║                                  ║
 ║(string=? (first p) ║                    ║  (has-path? (node-r bt) (rest p))║
 ║          "R")      ║                    ║                                  ║
 ║                    ║                    ║                                  ║
 ╚════════════════════╩════════════════════╩══════════════════════════════════╝
)

(check-expect (has-path? false empty)  false)
(check-expect (has-path? false (cons "L" empty)) false)
(check-expect (has-path? false (cons "L" (cons "R" empty))) false)
(check-expect (has-path? false (cons "R" empty)) false)
(check-expect (has-path? BT3  empty) true)
(check-expect (has-path? BT2  empty) true)
(check-expect (has-path? BT3 (cons "L" empty)) true)
(check-expect (has-path? BT3 (cons "L" empty)) true)
(check-expect (has-path? BT2 (cons "R" empty)) false)
(check-expect (has-path? BT3 (cons "L" (cons "R" empty))) true)
(check-expect (has-path? BT2 (cons "L" (cons "R" empty))) false)

;(define (has-path? bt p) false) ; stub

#;
(define (has-path? bt p)
  (cond [(false? bt) false]
        [(empty? p) true]
        [(string=? "L" (first p)) (has-path? (node-l bt) (rest p))]
        [else (has-path? (node-r bt) (rest p))]))


;; The following is needed to run all the check-expects
(test)